function [transvec] = count_face_repetition(auxmat)
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here
%global face element
%auxmat = element.faces(loc_elem,:);
auxvec = reshape(auxmat,[],1);
[count, uniq_element] = hist(auxvec, unique(auxvec));
transvec = sparse(uniq_element',ones(size(uniq_element,2),1), count);
transvec = full(transvec(auxmat));
end