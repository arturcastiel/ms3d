function [filt_matrix] = filter_matrix(auxmat,vec)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
max_val = max(max(auxmat));
if ~any(vec == max_val)
    vec = [vec; max_val];
    val = ones(size(vec));
    val(end) = 0;

end
trans_matrix = sparse(vec, ones(size(vec)),val);
filt_matrix = full(trans_matrix(auxmat));
end