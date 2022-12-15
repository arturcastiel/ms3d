function [auxmat] = integrity_face_color_array(auxmat)
%integrity_face Ensures that the elements of a sub_face are always face
%connected
%   This is done by ensuring that each internal face appears always twice
%   in the same group of connected elements
global element
num_col = max(size(auxmat,2));
for index = 1:num_col
    loc_elem = auxmat == index;
    count_matrix = count_face_repetition(element.faces(loc_elem,:));
    loc_elem(loc_elem) = any(count_matrix == 2,2);
    auxmat(loc_elem) = index;
end
end