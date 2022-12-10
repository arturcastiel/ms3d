function [volume] = volume_tetrahedron(coord,elem)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes herep
A = coord(elem(:,1),:);
B = coord(elem(:,2),:);
C = coord(elem(:,3),:);
D = coord(elem(:,4),:);

AB = B-A;
AC = C-A;
AD = D-A;

volume = (1/6)*dot(AD,cross(AB,AC,2),2);
end