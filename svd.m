% Clear any previous figures and hold the plot
figure;
hold off;
axis([0 640 0 480]);  % Define initial axis limits

% Get 4 points from the user for the homography calculation
[X, Y] = ginput(4);  % Select four points

% Plot the polygon formed by these points in red
plot([X; X(1)], [Y; Y(1)], 'r');  % Close the polygon

hold on;  % Hold the plot to overlay the next plot

% Define the corners of the destination rectangle
plot([0 0 640 640 0], [0 480 480 0 0], 'b');  % Blue rectangle

% Set axis limits for both original and transformed points
axis([-100 900 -100 580]);

% Source (X, Y) points
Xp = [0; 0; 640; 640];
Yp = [0; 480; 480; 0];

% Construct the matrix B for the homography equation
B = zeros(8, 9);  % Initialize matrix B

for i = 1:4
    x = X(i);
    y = Y(i);
    xp = Xp(i);
    yp = Yp(i);

    % Construct the system of equations for each point pair (X, Y) -> (Xp, Yp)
    B(2*i-1, :) = [-x, -y, -1, 0, 0, 0, xp*x, xp*y, xp];  % Equation for x'
    B(2*i, :) = [0, 0, 0, -x, -y, -1, yp*x, yp*y, yp];    % Equation for y'
end

% Perform Singular Value Decomposition on matrix B
[U, S, V] = svd(B);

% The last column of V gives the solution to the homography matrix
h = V(:, end);  % Extract the last column of V

% Reshape h into a 3x3 homography matrix and transpose it
H = reshape(h, 3, 3)';  % Transpose to get the correct homography matrix

% Display the computed homography matrix
disp('Homography matrix H:');
disp(H);

% Now let's start the interactive process of plotting transformed points
while true
    % Get two points for drawing a line segment
    [x1, y1] = ginput(1);  % First point
    [x2, y2] = ginput(1);  % Second point

    % Interpolate between the two points and apply the homography
    for u = 0:0.1:1
        % Interpolate coordinates between the two points
        x = u * x1 + (1 - u) * x2;
        y = u * y1 + (1 - u) * y2;

        % Plot the original points (red 'x')
        plot(x, y, 'xr');  % Original points

        % Apply the homography to the points
        t = H * [x; y; 1];  % Transform the point with the homography
        t = t / t(3);  % Normalize by the third coordinate to get Cartesian coordinates

        % Plot the transformed points (blue 'o')
        plot(t(1), t(2), 'ob');  % Transformed points
    end

    % Pause for a moment to allow the plot to update before continuing
    drawnow;
end
