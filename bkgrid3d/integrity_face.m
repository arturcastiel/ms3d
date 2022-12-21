function [auxmat] = integrity_face(auxmat, mesh)
%integrity_face Ensures that the elements of a sub_face are always face
%connected
%   This is done by ensuring that each internal face appears always twice
%   in the same group of connected elements
num_col = size(auxmat,2);
for index = 1:num_col
    loc_elem = auxmat(:,index);
    count_matrix = count_face_repetition(mesh.element.faces(loc_elem,:));
    loc_elem(loc_elem) = any(count_matrix == 2,2);
    auxmat(:,index) = loc_elem;
end
end