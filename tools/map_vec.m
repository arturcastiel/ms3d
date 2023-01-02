function [matrix] = map_vec(matrix,key_val)
transformation_matrix = ...
    sparse(key_val(:,1), ones(size(key_val,1),1), key_val(:,2));
ref = ismember(matrix,key_val(:,1));
matrix(~ref) = 0;
member_elem = matrix(ref);
if ~issparse(member_elem)
    matrix(ref) = full(transformation_matrix(member_elem));
else
    matrix(ref) = transformation_matrix(member_elem);
end
end