function [faces_normal_area]= guide_normals_inner ...
    (upstream, downstream, faces_normal_area, element_centroid)
%guide_inner_neighbour Switches the order of the neighbours to ensure the
%vector comprised by the col1 element centrod to the face centroid and the
%normals have a positive dot product.

vol_to_vol_vec = element_centroid(upstream(:,1),:) - ...
                                       element_centroid(downstream(:,1),:);
vol_to_vol_dot_normal = dot(vol_to_vol_vec, ...
                                            faces_normal_area,2);
ref = vol_to_vol_dot_normal > 0;
faces_normal_area(ref,:) = -faces_normal_area(ref,:);
% inner_faces_neigh(ref,:) = [inner_faces_neigh(ref, 2) ...
%                                         inner_faces_neigh(ref,1)];
% 
% upstream = inner_faces_neigh(:,1);
% downstream = inner_faces_neigh(:,2);
end