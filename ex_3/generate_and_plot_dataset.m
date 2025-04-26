% Example 3.1: K-Means Clustering

% To generate the data
Mean1=[-4; -1]; Std1=1.9;
Mean2=[3; 4]; Std2 = 2.0;
Samples=200;
data1=Std1*randn(2, Samples) + repmat(Mean1, 1, Samples);
data2=Std2*randn(2, Samples) + repmat(Mean2, 1, Samples);

% To plot the two clusters
plot(data1(1,:),data1(2,:),'or');
hold on
plot(data2(1,:),data2(2,:),'+b');

% To plot the data together
figure
plot([data1(1,:) data2(1,:)],[data1(2,:) data2(2,:)],'or');

datatogether=[data1 data2];
[m,n]=size(datatogether);

% To randomly select two centroids
centroid1=datatogether(1:2,10);
centroid2=datatogether(1:2,250);
MaxIterations=20;

% To divide the data into two clusters
for i=1:1:MaxIterations
    
    cluster1=[];
    cluster2=[];
    centroid1old=centroid1;
    
    for j=1:1:n
        distance1=(datatogether(:,j)-centroid1)'*(datatogether(:,j)-centroid1);
        distance2=(datatogether(:,j)-centroid2)'*(datatogether(:,j)-centroid2);
        if distance1 <= distance2
           cluster1=[cluster1 datatogether(:,j)];
        else
           cluster2=[cluster2 datatogether(:,j)];
        end
    end
    centroid1=(mean(cluster1'))';
    centroid2=(mean(cluster2'))';
    
    % To stop the loop if the centroid is not changing
    if centroid1 == centroid1old
       break
    end
end

% To plot the result of K-Means clustering
figure
plot(cluster1(1,:),cluster1(2,:),'+b');
hold on
plot(cluster2(1,:),cluster2(2,:),'or');
hold on
