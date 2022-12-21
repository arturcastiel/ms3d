function [k_eq, height_left] = calc_bound_face_project_permeability(vertex, face, element, flagstruct)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
k_left = flagstruct.permeablity_list...
                                (element.region(face.bound.upstream),:);
normals = face.bound.normal;
areas = face.bound.area;
[k_eq] = project_perm_tensor(normals, k_left, areas);
node_J = vertex.coord(face.bound.vertices(:,2),:);
left_centroid = element.centroid(face.bound.upstream,:); 
LJ = node_J - left_centroid; 
height_left = abs(dot(LJ,normals,2))./areas; 
end


