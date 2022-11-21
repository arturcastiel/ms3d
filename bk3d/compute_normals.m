function [normals] = compute_normals(adj,coord)
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here
p1 = coord(adj(:,1),:);
p2 = coord(adj(:,2),:);
p3 = coord(adj(:,3),:);
vec1 = p2-p1;
vec2 = p3-p1;
normals = cross(vec1,vec2,2);
end