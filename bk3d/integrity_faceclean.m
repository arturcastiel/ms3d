function [ref] = integrity_faceclean(loc_elem)
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
ref = sum(ref,2) == 1;
loc_elem(ref) = 0;
ref = loc_elem;
end