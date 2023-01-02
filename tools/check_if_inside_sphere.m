function [radius] = check_if_inside_sphere(center, coords)
n = size(coords,1);
x = coords(:,1);
y = coords(:,2);
z = coords(:,3);
x_c = repelem(center(:,1),n,1);
y_c = repelem(center(:,2),n,1);
z_c = repelem(center(:,3),n,1);
term = (x - x_c).^2 + (y - y_c).^2 + (z - z_c).^2;
radius = term .^ .5;
end