function [shifted_matrix] = shift_left(matrix)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
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