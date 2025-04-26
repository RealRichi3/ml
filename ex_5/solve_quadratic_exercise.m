% Filename: solve_quadratic_exercise.m

% Step 1: Generate a Noisy Quadratic Curve
% Parameters
A = 1.6;
B = 2.5;
C = 6;

% Generate x values
x = linspace(-4, 6, 100);

% Generate Gaussian noise
noise = 5 * randn(1, 100);

% Calculate y values
y = A * x.^2 + B * x + C + noise;

% Plot the noisy quadratic curve
figure;
scatter(x, y, 'filled');
title('Noisy Quadratic Curve');
xlabel('x');
ylabel('y');
legend('Noisy Data');

% Step 2: Fit the Quadratic Curve Using Linear Regression
% Prepare the design matrix
X = [x.^2; x; ones(1, 100)]';

% Perform linear regression
b = regress(y', X);

% Display the coefficients
fprintf('Estimated coefficients:\nA = %.2f\nB = %.2f\nC = %.2f\n', b(1), b(2), b(3));

% Plot the fitted curve
y_fit = b(1) * x.^2 + b(2) * x + b(3);

% Plot the noisy data with the fitted curve
figure;
scatter(x, y, 'filled');
hold on;
plot(x, y_fit, 'r', 'LineWidth', 2);
title('Noisy Data with Fitted Curve');
xlabel('x');
ylabel('y');
legend('Noisy Data', 'Fitted Curve'); 