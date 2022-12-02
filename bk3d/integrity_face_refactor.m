function [loc_elem] = integrity_face_refactor(loc_elem)
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here
global face element
new_loc = false(size(loc_elem));
num_inner = size(face.inner.centroid,1);
auxmat = element.faces(loc_elem,:);
auxmat(auxmat > num_inner) =0;
loc_faces = setdiff(unique(auxmat),0);
neigh_face_elem = ...
    unique([face.inner.juselem(loc_faces); face.inner.juselem(loc_faces)]);
new_loc(neigh_face_elem) = true;
new_loc(loc_elem) = false;
face_adj = element.faces(new_loc,:);
ref_b = any(face_adj > num_inner,2);
face_adj(ref_b) = loc_faces(1);
auxsum = sum(ismember(face_adj,loc_faces),2);
loc_elem(new_loc) = auxsum > 2;
end