function [gvp_parameter] = calc_bound_gvp(vertex, face, element, ...
                                         h_left, kp_left, flagstruct)
gvp_parameter = zeros(size(face.bound.area,1),3);
k_left = flagstruct.permeablity_list...
                                (element.region(face.bound.upstream),:);
areas = face.bound.area;
node_I = vertex.coord(face.bound.vertices(:,1),:);
node_J = vertex.coord(face.bound.vertices(:,2),:);
node_K = vertex.coord(face.bound.vertices(:,3),:);
left_centroid = element.centroid(face.bound.upstream,:); 
LJ = node_J - left_centroid;
JI = node_I - node_J; 
JK = node_K - node_J; 
normals = face.bound.normal; 
TJI=cross(normals,JI,2); 
TJK=cross(normals,JK,2);
areas_square = areas.*areas;
KTJIL = multiply_vec_tensor_vec(normals,k_left, TJI)./areas_square;
KTJKL = multiply_vec_tensor_vec(normals,k_left, TJK)./areas_square;
dTJK = dot(-TJK,LJ,2);
dTJI = dot(-TJI,LJ,2);
gvp_parameter(:,1) =  -((kp_left.*dTJK) + ...
                        (areas.*KTJKL.*h_left))./(2*areas.*h_left); 
gvp_parameter(:,2) =  ((kp_left.*dTJK) - (kp_left.*dTJI) + ...
    (2*areas_square.*kp_left) - (areas.*KTJIL.*h_left) + ...
    (areas.*KTJKL.*h_left))./(2*areas.*h_left); 
gvp_parameter(:,3) = ((kp_left.*dTJI) + ...
                        (areas.*KTJIL.*h_left))./(2*areas.*h_left); 
end