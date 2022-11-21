function [F, fElem, bfaces] = create_faces(elem)
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
    ref_trian = elem(:,end) == 0;
    F_trian = [elem(ref_trian,1:2); elem(ref_trian,2:3); [elem(ref_trian,3) elem(ref_trian,1)]];
    F_quad =  [elem(~ref_trian,1:2); elem(~ref_trian,2:3); elem(~ref_trian,3:4); [elem(~ref_trian,4) elem(~ref_trian,1)]];  

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
end

