function [inner_faces_neigh]= guide_inner_neighbour(inner_faces_neigh, ...
   inner_faces_normal_area,inner_faces_centroid,element_centroid)
%guide_inner_neighbour Switches the order of the neighbours to ensure the
%vector comprised by the col1 element centrod to the face centroid and the
%normals have a positive dot product.
face_center_element_vec = element_centroid(inner_faces_neigh(:,1),:) - ...
                                                inner_faces_centroid;
face_cent_el_vec_dot_normal = dot(face_center_element_vec, ...
                                            inner_faces_normal_area,2);
ref = face_cent_el_vec_dot_normal < 0;
inner_faces_neigh(ref,:) = [inner_faces_neigh(ref, 2) ...
                                        inner_faces_neigh(ref,1)];

upstream = inner_faces_neigh(:,1);
downstream = inner_faces_neigh(:,2);
end