function PlotTwoClasses(data, class, theTitle)
% plot the two classes according to class

% decode  class 0
fidx = find(class==0);
c1data = data(:,fidx);

% decode  class 1
fidx = find(class==1);
c2data = data(:,fidx);

figure
hold on
h = plot(c1data(1, :), c1data(2, :),'b.');
set(h, 'linewidth', 3, 'MarkerSize', 15);

h = plot(c2data(1, :), c2data(2, :),'r.');
set(h, 'linewidth', 3, 'MarkerSize', 15);

h=xlabel('x-value');
set(h, 'FontSize', 20);

h=ylabel('y-value');
set(h, 'FontSize', 20);

axis square
axis([-10 10 -10 10])

targetPatternh = legend('Class 1', 'Class 2');
set(h, 'FontSize', 20);

h=title(theTitle);
set(h, 'FontSize', 20);

% axis numbering
set(gca, 'FontSize', 20)