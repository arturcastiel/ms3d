function [gvp_parameter] = calc_inner_gvp(vertex, face, element, ...
                            kp_left, kp_right, h_left, h_right, flagstruct)
gvp_parameter = zeros(size(face.inner.area,1),3);
k_left = flagstruct.permeablity_list...
                                (element.region(face.inner.upstream),:);
k_right = flagstruct.permeablity_list...
                                (element.region(face.inner.downstream),:);
areas = face.inner.area;
node_I = vertex.coord(face.inner.vertices(:,1),:);
node_J = vertex.coord(face.inner.vertices(:,2),:);
node_K = vertex.coord(face.inner.vertices(:,3),:);
left_centroid = element.centroid(face.inner.upstream,:); 
right_centroid = element.centroid(face.inner.downstream,:); 
% LJ = node_J - left_centroid; 
% RJ = node_J - right_centroid;
JI = node_I - node_J; 
JK = node_K - node_J; 
LR = right_centroid - left_centroid; 
normals = face.inner.normal; 
TJI=cross(normals,JI,2); 
TJK=cross(normals,JK,2);
areas_square = areas.*areas;
areas_inv = 1./areas;
KTJIL = multiply_vec_tensor_vec(normals,k_left, TJI)./areas_square;
KTJIR = multiply_vec_tensor_vec(normals,k_right, TJI)./areas_square;
KTJKL = multiply_vec_tensor_vec(normals,k_left, TJK)./areas_square;
KTJKR = multiply_vec_tensor_vec(normals,k_right, TJK)./areas_square;
DJI = (dot(TJI,LR,2)./(areas_square)) ...
    - (areas_inv).*(h_left.*(KTJIL./kp_left) + h_right.*(KTJIR./kp_right));
DJK = (dot(TJK,LR,2)./(areas_square)) ...
    - (areas_inv).*(h_left.*(KTJKL./kp_left) + h_right.*(KTJKR./kp_right));
gvp_parameter(:,1) = 0.5*DJK; 
gvp_parameter(:,2)  = 0.5*DJI-0.5*DJK; 
gvp_parameter(:,3)  = -0.5*DJI; 
end