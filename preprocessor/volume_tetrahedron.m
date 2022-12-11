function [volume] = volume_tetrahedron(coord,elem)
%volume_tetrahedron Calculates the volume of the tetrahedron based on
%the adjancencies in the rows of elem and its coordeinates in coord.
A = coord(elem(:,1),:);
B = coord(elem(:,2),:);
C = coord(elem(:,3),:);
D = coord(elem(:,4),:);
AB = B-A;
AC = C-A;
AD = D-A;
volume = (1/6)*dot(AD,cross(AB,AC,2),2);
end