% Filename: step1_generate_and_plot_datasets.m

% Set mean and covariance for class 0
Mean1 = [3; -1];
Sigma1 = [2 4; 4 10];

% Set mean and covariance for class 1
Mean2 = [-3; -1];
Sigma2 = [2 4; 4 10];

% Generate training dataset
trainingSamples = 10000;
[trainingData, trainingTarget] = GenerateGaussianData(trainingSamples, Mean1, Sigma1, Mean2, Sigma2);

% Generate testing dataset
testingSamples = 10000;
[testingData, testingTarget] = GenerateGaussianData(testingSamples, Mean1, Sigma1, Mean2, Sigma2);

% Convert binary vector to class
trainingClass = CollapseBinaryVectorToClass(trainingTarget);

% Plot the two classes of the training dataset
PlotTwoClasses(trainingData, trainingClass, 'Input training data');
title('Input training data'); 

% decode class 0
fidx = find(trainingClass==0);
S.cA_data = trainingData(:,fidx);
% decode class 1
fidx = find(trainingClass==1);
S.cB_data = trainingData(:,fidx);
% Estimate the naïve Bayes classifier sufficient statistics
% mean and marginal stds of class 0
S.MeanEstA(1) = mean(S.cA_data(1,:));
S.MeanEstA(2) = mean(S.cA_data(2,:));
S.StdEstA(1) = sqrt(var(S.cA_data(1,:)) );
S.StdEstA(2) = sqrt(var(S.cA_data(2,:)) );
% mean and marginal stds of class 1
S.MeanEstB(1) = mean(S.cB_data(1,:));
S.MeanEstB(2) = mean(S.cB_data(2,:));
S.StdEstB(1) = sqrt(var(S.cB_data(1,:)) );
S.StdEstB(2) = sqrt(var(S.cB_data(2,:)) );
% priors
S.P_A = length(S.cA_data)/length(trainingData);
S.P_B = length(S.cB_data)/length(trainingData);

% testing data
data = testingData;
% calculate P(x|a) and P(x|b) by putting values into Gauss function
P_x_Given_A = Gauss1D(data(1,:), S.MeanEstA(1), S.StdEstA(1)) .* Gauss1D(data(2,:), S.MeanEstA(2), S.StdEstA(2));
P_x_Given_B = Gauss1D(data(1,:), S.MeanEstB(1), S.StdEstB(1)) .* Gauss1D(data(2,:), S.MeanEstB(2), S.StdEstB(2));

% Calculate P(a|x) and P(b|x) using Bayes rule
P_x = P_x_Given_A * S.P_A + P_x_Given_B * S.P_B; % Total probability
P_A_Given_x = (P_x_Given_A * S.P_A) ./ P_x; % P(a|x)=P(x|a)*P(a)/P(x)
P_B_Given_x = (P_x_Given_B * S.P_B) ./ P_x; % P(b|x)=P(x|b)*P(b)/P(x)

% Call associations to simplify notation
a = P_A_Given_x;
b = P_B_Given_x;
% Allocate data to most likely class
testingClass = zeros(1, length(data));
aidx = find(a > b);
bidx = find(b >= a);
% Set class
testingClass(aidx) = 0;
testingClass(bidx) = 1;
% Plot the two classes of the testing dataset
PlotTwoClasses(data, testingClass, 'Recognized on testing data');
title('Recognized on testing data');