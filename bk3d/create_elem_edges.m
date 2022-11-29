function [edges_elem] = create_elem_edges(fElem, face_edges)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
nel = size(fElem,1);
edges_elem = zeros(nel,12);
for ii = 1:nel
   local_faces = fElem(ii,:);
   local_faces = local_faces(local_faces ~= 0);
   local_edges = face_edges(local_faces,:);
   local_edges = setdiff(unique(local_edges),0);
   edges_elem(ii,:) = local_edges';
end
end