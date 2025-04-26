% Filename: generate_and_plot_dataset.m

% Initialize random number generator for reproducibility
rng(0);

% Step 1: Generate Dataset
% Cluster 1
mean1 = [-4, -1];
std_dev1 = 0.75;
cluster1 = std_dev1 * randn(1000, 2) + mean1;

% Cluster 2
mean2 = [3, 4];
std_dev2 = 2.0;
cluster2 = std_dev2 * randn(1000, 2) + mean2;

% Plot the clusters
figure;
scatter(cluster1(:,1), cluster1(:,2), 'r.');
hold on;
scatter(cluster2(:,1), cluster2(:,2), 'b.');
title('2D Uncorrelated Dataset with Overlapping Clusters');
xlabel('X-axis');
ylabel('Y-axis');
legend('Cluster 1', 'Cluster 2');
hold off;
