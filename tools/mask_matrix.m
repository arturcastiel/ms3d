function [map] = mask_matrix(matrix, mvec)
ref = matrix(:,end) == 0;
matrix(ref,1:3) = mvec(matrix(ref,1:3));
matrix(~ref,:) = mvec(matrix(~ref,:));
map = matrix;
end