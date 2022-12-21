function [ref] = check_if_line_crosses_plane(list_faces, p_left,p_right, face, vertex)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
num_inner_faces = size(face.inner.centroid,1);
ref_bfaces = list_faces > num_inner_faces;
face_center = zeros(size(list_faces,1),3);
face_normal = zeros(size(list_faces,1),3);
face_area = zeros(size(list_faces,1),1);
face_area(~ref_bfaces) = face.inner.area(list_faces(~ref_bfaces));
face_area(ref_bfaces) = face.bound.area(list_faces(ref_bfaces) - ... 
                                                        num_inner_faces);
face_center(~ref_bfaces,:) = ...
    face.inner.centroid(list_faces(~ref_bfaces),:);
face_center(ref_bfaces,:) = ...
    face.bound.centroid((list_faces(ref_bfaces) - num_inner_faces),:);
face_normal(~ref_bfaces,:) = ...
    face.inner.normal(list_faces(~ref_bfaces),:);
face_normal(ref_bfaces,:) = ...
    face.bound.normal((list_faces(ref_bfaces) - num_inner_faces),:);
face_normal = face_normal ./ vecnorm(face_normal,2,2);
p1(ref_bfaces,:) = ...
    vertex.coord(face.bound.vertices(list_faces(ref_bfaces) - num_inner_faces ,1),:);
p1(~ref_bfaces,:) = ...
    vertex.coord(face.inner.vertices(list_faces(~ref_bfaces),1),:);
p2(ref_bfaces,:) = ...
    vertex.coord(face.bound.vertices(list_faces(ref_bfaces) - ...
    num_inner_faces ,2),:);
p2(~ref_bfaces,:) = ...
    vertex.coord(face.inner.vertices(list_faces(~ref_bfaces),2),:);
p3(ref_bfaces,:) = ...
    vertex.coord(face.bound.vertices(list_faces(ref_bfaces) - ...
    num_inner_faces ,3),:);
p3(~ref_bfaces,:) = ...
    vertex.coord(face.inner.vertices(list_faces(~ref_bfaces),3),:);
vecline = p_right - p_left;
p_intersect = point_plane_intersection(p_left, vecline, face_center,  ...
                                       face_normal);
ref = check_if_point_in_middle_semi_line(p_intersect, p_left, p_right);
lref = check_point_in_triang(p_intersect(ref,:), p1(ref,:),p2(ref,:), ...
                                               p3(ref,:) , face_area(ref));
ref(ref) = lref;
end

function[ref] = check_if_point_in_middle_semi_line(p_check, p1, p2)
tol = 10^-10;
dtotal = vecnorm(p2-p1,2,2);
p1 = repmat(p1,size(p_check,1),1);
p2 = repmat(p2,size(p_check,1),1);
dtotal = repmat(dtotal,size(p_check,1),1);
d1 = vecnorm(p_check-p1,2,2);
d2 = vecnorm(p_check-p2,2,2);
R = abs(dtotal - d1 - d2);
ref = abs(R) <= tol;
end
function [ref] = check_point_in_triang(pa, p1,p2,p3, Atotal)
tol = 10^-10;
A1 = calc_area_triang_using_coords(pa,p1,p2);
A2 = calc_area_triang_using_coords(pa,p2,p3);
A3 = calc_area_triang_using_coords(pa,p1,p3);
% A1 = calc_area_triang(pa,p1,p2);
% A2 = calc_area_triang(pa,p2,p3);
% A3 = calc_area_triang(pa,p1,p3);

%Atotal = calc_area_triang(p1,p2,p3);
Apartial = A1+A2+A3;
ref = abs(Atotal-Apartial) <= tol;
end

function [p_intersect ] = point_plane_intersection(pv, vecv, pp, vecp)
% pv -> point in line, vecv-> vector in the direction of the line
% pp -> point in plane, vecp-> normal vector
pv = repmat(pv,size(pp,1),1);
vecv = repmat(vecv,size(pp,1),1);
t = dot(vecp,pp-pv,2) ./ dot(vecp,vecv,2);
p_intersect = pv + t.*vecv;
end


