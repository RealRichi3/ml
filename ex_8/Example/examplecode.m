% This is the example code for remaining useful life estimation using CNN

% Preprocess Training data
rawTrain = localLoadData('train_FD001.txt');

% Examine the run-to-failure data for the first lens
head(rawTrain.X{1},8);
rawTrain.Y{1}(1:8)

% Visualize the time-series data for some of the predictors
stackedplot(rawTrain.X{1},[3,5,6,7,8,15,16,24],XVariable='timeStamp')

% Remove features with less variability
prog = prognosability(rawTrain.X,"timeStamp");
idxToRemove = prog.Variables==0 | isnan(prog.Variables);
featToRetain = prog.Properties.VariableNames(~idxToRemove);
for i = 1:height(rawTrain)
    rawTrain.X{i} = rawTrain.X{i}{:,featToRetain};
end

% Normalize training predictors
[~,Xmu,Xsigma] = zscore(vertcat(rawTrain.X{:}));
preTrain = table();
for i = 1:numel(rawTrain.X)
    preTrain.X{i} = (rawTrain.X{i} - Xmu) ./ Xsigma;
end

% Clip the responses causes the network to treat instances with higher RUL values (>200) as equal
rulThreshold = 150;
for i = 1:numel(rawTrain.Y)
    preTrain.Y{i} = min(rawTrain.Y{i},rulThreshold);
end

% Prepare data for padding
for i = 1:size(preTrain,1)
    preTrain.X{i} = preTrain.X{i}';    %Transpose training data to have features in the first dimension
    preTrain.Y{i} = preTrain.Y{i}';    %Transpose responses corresponding to the training data
    sequence = preTrain.X{i};
    sequenceLengths(i) = size(sequence,2);
end
[sequenceLengths,idx] = sort(sequenceLengths,'descend');
XTrain = preTrain.X(idx);
YTrain = preTrain.Y(idx);

% Specify the network architecture
numFeatures = size(XTrain{1},1);
numHiddenUnits = 100;
numResponses = 1;

layers = [
    sequenceInputLayer(numFeatures)
    convolution1dLayer(5,32,Padding="causal")
    batchNormalizationLayer()
    reluLayer()
    convolution1dLayer(7,64,Padding="causal")
    batchNormalizationLayer
    reluLayer()
    convolution1dLayer(11,128,Padding="causal")
    batchNormalizationLayer
    reluLayer()
    convolution1dLayer(13,256,Padding="causal")
    batchNormalizationLayer
    reluLayer()
    convolution1dLayer(15,512,Padding="causal")
    batchNormalizationLayer
    reluLayer()
    fullyConnectedLayer(numHiddenUnits)
    reluLayer()
    dropoutLayer(0.5)
    fullyConnectedLayer(numResponses)
    regressionLayer()];

% Train network
maxEpochs = 40;
miniBatchSize = 16;

options = trainingOptions('adam',...
    LearnRateSchedule='piecewise',...
    MaxEpochs=maxEpochs,...
    MiniBatchSize=miniBatchSize,...
    InitialLearnRate=0.01,...
    GradientThreshold=1,...
    Shuffle='never',...
    Plots='training-progress',...
    Verbose=0);
net = trainNetwork(XTrain,YTrain,layers,options);

figure;
lgraph = layerGraph(net.Layers);
plot(lgraph)

% Test network
filenameTestPredictors = 'test_FD001.txt';
filenameTestResponses = 'RUL_FD001.txt'; % the original #2 #6 #8 #12 #14 #18
dataTest = localLoadData(filenameTestPredictors,filenameTestResponses);

for i = 1:numel(dataTest.X)
    dataTest.X{i} = dataTest.X{i}{:,featToRetain};
    dataTest.X{i} = (dataTest.X{i} - Xmu) ./ Xsigma;
    dataTest.Y{i} = min(dataTest.Y{i},rulThreshold);
end

predictions = table(Size=[height(dataTest) 2],VariableTypes=["cell","cell"],VariableNames=["Y","YPred"]);
for i=1:height(dataTest)
    unit = dataTest.X{i}';   
    predictions.Y{i} = dataTest.Y{i}';
    predictions.YPred{i} = predict(net,unit,MiniBatchSize=1);
end

for i = 1:size(predictions,1)
    predictions.RMSE(i) = sqrt(mean((predictions.Y{i} - predictions.YPred{i}).^2));
end

figure;
histogram(predictions.RMSE,NumBins=10);
title("RMSE ( Mean: " + round(mean(predictions.RMSE),2) + " , StDev: " + round(std(predictions.RMSE),2) + " )");
ylabel('Frequency');
xlabel('RMSE');

figure;
localLambdaPlot(predictions,"random");
figure;
localLambdaPlot(predictions,"best");
figure;
localLambdaPlot(predictions,"worst");
figure;
localLambdaPlot(predictions,"average");
