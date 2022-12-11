function [normals] = compute_normals(adj,coord)
% compute_normals based on the adj and coords
%   normals is an unitary vector
p1 = coord(adj(:,1),:);
p2 = coord(adj(:,2),:);
p3 = coord(adj(:,3),:);
vec1 = p2-p1;
vec2 = p3-p1;
normals = cross(vec1,vec2,2);
normals = normals ./ vecnorm(normals,2,2);
end