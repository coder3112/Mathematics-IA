% Set up an array of points
x_points = [1,3,3,1];
y_points = [1,1,0,0];
points = [x_points; y_points];

coord_mat=[2,0;0,2]

for p = 1:size(points,2)
  coord_pts(:,p) = coord_mat * points(:,p);
end

% Plots
clf;
plot(0,0,'+k', 'DisplayName', 'Origin');
hold on; grid on;
plot(points(1,:), points(2,:), 'x-k', 'DisplayName', 'Original Points');
plot(coord_pts(1,:), coord_pts(2,:), 'x-b', 'DisplayName', 'Scaled Points through calculated matrix');
legend show; axis equal;