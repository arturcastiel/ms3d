function [mref] = plane_boundbox(plane, plane_normal, plane_center, coords)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
n = size(plane,1);

re_plane_normal = repelem(plane_normal,n,1);
vol_center = plane_center + 0.5*plane_normal;

auxmat = (plane+re_plane_normal);
%around_normals = zeros(size(auxmat));
mref = true(size(coords,1),1);
%creating a boundary box
for ii = 1:n
    p1 = plane(ii,:);
    if ii == n
        p2 = plane(1,:);
    else
        p2 = plane(ii+1,:);
    end
    p3 = auxmat(ii,:);
    fcenter = (p1+p2+p3)/3;
    around_normal = cross(p3-p1, p2-p1);
    %around_normals(ii,:) = around_normal;
    [ref] = semi_plane_check(coords, around_normal , ...
        fcenter, vol_center);
    mref = mref & ref;
    
end

end