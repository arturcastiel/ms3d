function [loc_elem] = integrity_face(loc_elem)
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here
global element
count_matrix = count_face_repetition(element.faces(loc_elem,:));
loc_elem(loc_elem) = any(count_matrix == 2,2);
end