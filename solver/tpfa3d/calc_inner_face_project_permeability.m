function [k_projct_left,k_projct_right, height_left, height_right] = ...
    calc_inner_face_project_permeability(vertex, face, element, flagstruct)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
k_left = flagstruct.permeablity_list...
                                (element.region(face.inner.upstream),:);
k_right = flagstruct.permeablity_list...
                                (element.region(face.inner.downstream),:);
normals = face.inner.normal;
areas = face.inner.area;
[k_projct_left] = project_perm_tensor(normals, k_left, areas);
[k_projct_right] = project_perm_tensor(normals, k_right, areas);
%node_I = vertex.coord(face.inner.vertices(:,1),:)';
node_J = vertex.coord(face.inner.vertices(:,2),:);
%node_K = vertex.coord(face.inner.vertices(:,3),:)';
left_centroid = element.centroid(face.inner.upstream,:); 
right_centroid = element.centroid(face.inner.downstream,:); 
LJ = node_J - left_centroid; 
RJ = node_J - right_centroid;
height_left = abs(dot(LJ,normals,2))./areas; 
height_right = abs(dot(RJ,normals,2))./areas;
%[k_eq] = find_eqv_perm(k_projct_left,k_projct_right, height_left,...
%                                                height_right, areas);
%% nx*(a*nx + d*ny + g*nz) + ny*(b*nx + e*ny + h*nz) + nz*(c*nx + f*ny + i*nz)
end
