function [semi_plane] = ...
    is_split_by_plane(list_coord, normal, fcenter)
%   Returns 1
% 1 to points in one semiplane
% 2 to points in the other semiplane
n = size(list_coord,1);
semi_plane = zeros(n,1);
d = dot(normal, fcenter);
dt = ones(n,1)*d;
rep_normal= repelem(normal,n,1);
val = dot(rep_normal,list_coord,2) - dt;
semi_plane(val>0) = 1;
semi_plane(val<=0) = 2;

end