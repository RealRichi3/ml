% Filename: step2_concatenate_and_plot.m

% Load the generated clusters
load('cluster1.mat');
load('cluster2.mat');

% Concatenate the datasets
TrainData = [cluster1; cluster2];

% Plot the concatenated dataset in a single color
figure;
scatter(TrainData(:,1), TrainData(:,2), 'k.');
title('Concatenated Dataset');
xlabel('X-axis');
ylabel('Y-axis');
legend('Data Points');

% Save the concatenated dataset
save('TrainData.mat', 'TrainData'); 