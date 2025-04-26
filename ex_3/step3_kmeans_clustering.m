% Filename: step3_kmeans_clustering.m

% Load the concatenated dataset
load('TrainData.mat');

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