function [F, fElem, bfaces, face_neighbours] = create_bkfaces(elem)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

flag = 1;
if all(elem(:,end) == 0)
    elem = elem(:, 1:4);
    flag = 0;
end
%% if flag == 0 , only tetrahedron
% flag == 1, tetrahedron and hexahedron
if flag == 0
    F_trian = [elem(:,1) elem(:,2) elem(:,3); ...
        elem(:,1) elem(:,2) elem(:,4); ...
        elem(:,1) elem(:,3) elem(:,4); ...
        elem(:,2) elem(:,3) elem(:,4)];
       F_quad = [];
elseif flag == 1
    %% take a look on the quadrilateral face creation for hexahedron meshes
%     F_quad = [elem(:,1) elem(:,2) elem(:,3) elem(:,4); ...
%         elem(:,1) elem(:,5) elem(:,6) elem(:,2); ...
%         elem(:,1) elem(:,5) elem(:,2) elem(:,4); ...
%         elem(:,3) elem(:,4) elem(:,8) elem(:,7); ...
%         elem(:,3) elem(:,2) elem(:,6) elem(:,7); ...
%         elem(:,5) elem(:,8) elem(:,7) elem(:,6)];
    F_quad = [elem(:,1) elem(:,2) elem(:,6) elem(:,5); ...
        elem(:,3) elem(:,7) elem(:,8) elem(:,4); ...
        elem(:,1) elem(:,4) elem(:,8) elem(:,5); ...
        elem(:,2) elem(:,3) elem(:,7) elem(:,6); ...
        elem(:,1) elem(:,4) elem(:,3) elem(:,2); ...
        elem(:,5) elem(:,8) elem(:,7) elem(:,6)];
       F_trian = [];  

end
F = [F_trian; F_quad];
F = sort(F,2);
F = unique(F,'rows');
flag = zeros(size(elem,1),1);
fElem = zeros(size(elem,1),6);
for index = 1:size(F,1)    
    ref = sum(ismember(elem,F(index,:)),2) > 2;
    flag(ref) = flag(ref) + 1;
    for ii = find(ref)'        
        fElem(ii, flag(ii)) = index;
    end
end

%% counts the number of times that a face appear in F
a = setdiff(unique(fElem),0);
tmpmat = fElem(:);
tmpmat = tmpmat(tmpmat~=0);
tmp = [a,histc(tmpmat,a)];
bfaces =  (tmp(:,2) == 1);
%% creating faces_neighbours
face_neighbours = zeros(size(bfaces,1),2);
for ii = 1:size(bfaces,1)
    local_neighbours = find(any(ismember(fElem,ii),2));
    if any(size(local_neighbours) > 1)
        face_neighbours(ii,1:2) = local_neighbours;
    else
        face_neighbours(ii,1) = local_neighbours;
    end
end

