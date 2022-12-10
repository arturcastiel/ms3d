function [ref] = is_on_plane(list_coord, normal, fcenter)
% 
%  returns 1 if points are on the same plane created by
%  normal and fcenter
tol = 10^-8;
n = size(list_coord,1);
d = dot(normal, fcenter);
dt = ones(n,1)*d;
rep_normal= repelem(normal,n,1);
val = dot(rep_normal,list_coord,2) - dt;
ref = abs(val) < tol;
end