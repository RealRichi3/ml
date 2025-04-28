# Technical Documentation: K-means Clustering Process

## Overview
This document provides a detailed explanation of the MATLAB scripts used to generate a dataset, concatenate it, and perform K-means clustering. The process is divided into three steps, each implemented in a separate script.

## Step 1: Dataset Generation (`step1_generate_dataset.m`)

### Purpose
The script generates a synthetic dataset with two overlapping clusters to simulate real-world data for clustering analysis.

### Code Explanation
- **Random Number Generator Initialization**:
  ```matlab
  rng(0);
  ```
  This line initializes the random number generator to ensure reproducibility of the generated data.

- **Cluster Generation**:
  ```matlab
  mean1 = [-4, -1];
  std_dev1 = 0.75;
  cluster1 = std_dev1 * randn(1000, 2) + mean1;
  ```
  - **Cluster 1**: Generates 1000 data points with a mean of \([-4, -1]\) and a standard deviation of 0.75.
  - **Cluster 2**: Similar code is used to generate 1000 data points with a mean of \([3, 4]\) and a standard deviation of 2.0.

- **Plotting**:
  ```matlab
  scatter(cluster1(:,1), cluster1(:,2), 'r.');
  scatter(cluster2(:,1), cluster2(:,2), 'b.');
  ```
  This code plots the two clusters with distinct colors (red for Cluster 1 and blue for Cluster 2) to visualize the dataset.

- **Saving**:
  ```matlab
  save('cluster1.mat', 'cluster1');
  save('cluster2.mat', 'cluster2');
  ```
  The generated clusters are saved to `cluster1.mat` and `cluster2.mat` for later use.

## Step 2: Dataset Concatenation (`step2_concatenate_and_plot.m`)

### Purpose
This script concatenates the two clusters into a single dataset and plots the result.

### Code Explanation
- **Loading**:
  ```matlab
  load('cluster1.mat');
  load('cluster2.mat');
  ```
  The previously generated clusters are loaded from `cluster1.mat` and `cluster2.mat`.

- **Concatenation**:
  ```matlab
  TrainData = [cluster1; cluster2];
  ```
  The two clusters are combined into a single dataset named `TrainData`.

- **Plotting**:
  ```matlab
  scatter(TrainData(:,1), TrainData(:,2), 'k.');
  ```
  The concatenated dataset is plotted in a single color (black) to visualize the combined data.

- **Saving**:
  ```matlab
  save('TrainData.mat', 'TrainData');
  ```
  The concatenated dataset is saved to `TrainData.mat` for further analysis.

## Step 3: K-means Clustering (`step3_kmeans_clustering.m`)

### Purpose
This script performs K-means clustering on the concatenated dataset to identify clusters within the data.

### Code Explanation
- **Loading**:
  ```matlab
  load('TrainData.mat');
  ```
  The concatenated dataset is loaded from `TrainData.mat`.

- **Parameters**:
  ```matlab
  k = 2; % Number of clusters
  max_iters = 100; % Maximum number of iterations
  ```
  The number of clusters (\(k = 2\)) and the maximum number of iterations for the K-means algorithm are set.

- **K-means Function**:
  ```matlab
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
  ```
  - **Initialization**: Randomly initializes the centroids by selecting \(k\) random points from the data.
  - **Iteration**: Iterates for a fixed number of iterations:
    - **Assignment**: Assigns each data point to the nearest centroid.
    - **Update**: Updates the centroids by computing the mean of the data points assigned to each cluster.
    - **Convergence Check**: Terminates the algorithm if the centroids do not change.

- **Running K-means**:
  ```matlab
  [centroids, idx] = kmeans_from_scratch(TrainData, k, max_iters);
  ```
  The `kmeans_from_scratch` function is called to perform clustering on the dataset.

- **Plotting**:
  ```matlab
  gscatter(TrainData(:,1), TrainData(:,2), idx);
  plot(centroids(:,1), centroids(:,2), 'kx', 'MarkerSize', 15, 'LineWidth', 3);
  ```
  The K-means results are plotted, showing the data points colored by cluster and the centroids marked with a black 'x'.

## Conclusion
This documentation provides a comprehensive overview of the MATLAB scripts used in the K-means clustering process. Each step is explained in detail, with references to the code and explanations of significant sections. If you have any questions or need further clarification, feel free to ask! 