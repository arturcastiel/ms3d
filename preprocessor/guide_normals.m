function [faces_normal_area]= guide_normals_bound(face_neigh, ...
   faces_normal_area,faces_centroid,element_centroid)
%guide_inner_neighbour Switches the order of the neighbours to ensure the
%vector comprised by the col1 element centrod to the face centroid and the
%normals have a positive dot product.
face_center_element_vec = element_centroid(face_neigh(:,1),:) - ...
                                                        faces_centroid;
face_cent_el_vec_dot_normal = dot(face_center_element_vec, ...
                                            faces_normal_area,2);
ref = face_cent_el_vec_dot_normal > 0;
faces_normal_area(ref,:) = -faces_normal_area(ref,:);
% inner_faces_neigh(ref,:) = [inner_faces_neigh(ref, 2) ...
%                                         inner_faces_neigh(ref,1)];
% 
% upstream = inner_faces_neigh(:,1);
% downstream = inner_faces_neigh(:,2);
end