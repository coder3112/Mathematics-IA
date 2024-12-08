% Set up an array of points
x_points = [-1,0.3,0.9,-1.5];
y_points = [1,1,-0.3,0.1];
points = [x_points; y_points];

% Rotation matrix
theta = 45;
rot_mat = [cosd(theta), -sind(theta);
           sind(theta),  cosd(theta)];
coord_mat=[0.690,-0.674;0.674,0.690]

% Rotate the points
for p = 1:size(points,2)
  rot_pts(:,p) = rot_mat * points(:,p);
end

for p = 1:size(points,2)
  coord_pts(:,p) = coord_mat * points(:,p);
end

% Plots
clf;
plot(0,0,'+k', 'DisplayName', 'Origin');
hold on; grid on;
plot(points(1,:), points(2,:), 'x-k', 'DisplayName', 'Original Points');
plot(rot_pts(1,:), rot_pts(2,:), 'x-r', 'DisplayName', 'Rotated Points through rotation directly by angle');
plot(coord_pts(1,:), coord_pts(2,:), 'x-b', 'DisplayName', 'Rotated Points through calculated matrix');
legend show; axis equal;