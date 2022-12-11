function [shifted_matrix] = shift_left(matrix)
%shift_left shift of the rows of a matrix to ensure the minimum value
%statys at the the first position.  The function ignores the 0 in a row.
%   INPUT: (Matrix)
%       | 2  1 0 0|
%       | 5  3 1 4|
%       | 4  3 1 0|
%       |10 54 9 0|
%   OUTPUT: (Matrix)
%       |1  2  0 0|
%       |1  4  5 3|
%       |1  4  3 0|
%       |9 10 54 0|
ref =  matrix(:,end) ~= 0;
mlist = min(matrix(ref,:),[],2);
while any(matrix(ref,1) ~= mlist)
    lref = matrix(ref,1) ~= mlist;
    cref = ref;
    cref(cref==true) = lref;
    matrix(cref,:) = circshift(matrix(cref,:),1,2);
end
mlist = min(matrix(~ref,1:3),[],2);
while any(matrix(~ref,1) ~= mlist)
    lref = matrix(~ref,1) ~= mlist;
    cref = ~ref;
    cref(cref==true) = lref;
    matrix(cref,1:3) = circshift(matrix(cref,1:3),1,2);
end
shifted_matrix = matrix;
end