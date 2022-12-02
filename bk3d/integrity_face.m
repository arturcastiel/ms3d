function [ref] = integrity_face(loc_elem)
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here
global face element
num_bound = size(face.bound.centroid,1);
num_inner = size(face.inner.centroid,1);
loc_bfaces = [1:num_bound] + num_inner;
loc_bfaces = loc_bfaces';
loc_faces = unique(element.faces(loc_elem,:));
loc = unique([loc_bfaces; loc_faces]);
ref = ismember(element.faces,loc);
ref_elem_with_bfaces = sum(element.faces > num_inner,2) == 2;
num_shared_faces = sum(ref,2);
ref = (num_shared_faces >= 3);
ref(ref_elem_with_bfaces) = num_shared_faces(ref_elem_with_bfaces) == 1;

end