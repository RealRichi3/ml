% Filename: combined_kmeans_clustering.m

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

% Plot the clusters with distinct colors
figure;
scatter(cluster1(:,1), cluster1(:,2), 'r.');
hold on;
scatter(cluster2(:,1), cluster2(:,2), 'b.');
title('2D Uncorrelated Dataset with Overlapping Clusters');
xlabel('X-axis');
ylabel('Y-axis');
legend('Cluster 1', 'Cluster 2');
hold off;

% Step 2: Concatenate the datasets
TrainData = [cluster1; cluster2];

% Plot the concatenated dataset in a single color
figure;
scatter(TrainData(:,1), TrainData(:,2), 'k.');
title('Concatenated Dataset');
xlabel('X-axis');
ylabel('Y-axis');
legend('Data Points');

% Step 3: Implement K-means Clustering
% Parameters
k = 2; % Number of clusters
max_iters = 100; % Maximum number of iterations

% K-means function
function [centroids, idx] = kmeans_from_scratch(data, k, max_iters)
    % Number of data points
    n = size(data, 1);
    
    % Randomly initialize the centroids by selecting k random points from the data
    rng(0); % For reproducibility
    centroids = data(randperm(n, k), :);
    
    % Initialize variables
    idx = zeros(n, 1);
    prev_centroids = centroids;
    
    % Iterate for a fixed number of iterations
    for iter = 1:max_iters
        % Step 1: Assign clusters
        for i = 1:n
            distances = sum((data(i, :) - centroids) .^ 2, 2);
            [~, idx(i)] = min(distances);
        end
        
        % Step 2: Update centroids
        for j = 1:k
            if any(idx == j)
                centroids(j, :) = mean(data(idx == j, :), 1);
            end
        end
        
        % Check for convergence (if centroids do not change)
        if isequal(prev_centroids, centroids)
            break;
        end
        prev_centroids = centroids;
    end
end

% Run K-means
[centroids, idx] = kmeans_from_scratch(TrainData, k, max_iters);

% Plot the K-means results
figure;
gscatter(TrainData(:,1), TrainData(:,2), idx);
hold on;
plot(centroids(:,1), centroids(:,2), 'kx', 'MarkerSize', 15, 'LineWidth', 3);
title('K-means Clustering Results');
xlabel('X-axis');
ylabel('Y-axis');
legend('Cluster 1', 'Cluster 2', 'Centroids');
hold off; 