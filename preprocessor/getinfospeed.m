%--------------------------------------------------------------------------
%FUNCTION "getinfoedge"
%--------------------------------------------------------------------------
function [bedge,inedge,centelem,elemvolume] = getinfospeed(coord,elem,bedgeref)


elem_adj = elem(:,1:end-1);

flag = 0;
if all(elem_adj(:,end) == 0)
    elem_adj = elem_adj(:, 1:4);
    flag = 0;
end
%% if flag == 0 , only tetrahedron
% flag == 1, tetrahedron and hexahedron
elem_ind = [1:size(elem,1)]';
elem_ind = [elem_ind; elem_ind; elem_ind; elem_ind];
if flag == 0
    F_trian = [elem_adj(:,1) elem_adj(:,2) elem_adj(:,3); ...
        elem_adj(:,1) elem_adj(:,2) elem_adj(:,4); ...
        elem_adj(:,1) elem_adj(:,3) elem_adj(:,4); ...
        elem_adj(:,2) elem_adj(:,3) elem_adj(:,4)];
       F_quad = [];
elseif flag == 1
    %% take a look on the quadrilateral face creation for hexahedron meshes
%     F_quad = [elem_adj(:,1) elem_adj(:,2) elem_adj(:,3) elem_adj(:,4); ...
%         elem_adj(:,1) elem_adj(:,5) elem_adj(:,6) elem_adj(:,2); ...
%         elem_adj(:,1) elem_adj(:,5) elem_adj(:,2) elem_adj(:,4); ...
%         elem_adj(:,3) elem_adj(:,4) elem_adj(:,8) elem_adj(:,7); ...
%         elem_adj(:,3) elem_adj(:,2) elem_adj(:,6) elem_adj(:,7); ...
%         elem_adj(:,5) elem_adj(:,8) elem_adj(:,7) elem_adj(:,6)];
    F_quad = [elem_adj(:,1) elem_adj(:,2) elem_adj(:,6) elem_adj(:,5); ...
        elem_adj(:,3) elem_adj(:,7) elem_adj(:,8) elem_adj(:,4); ...
        elem_adj(:,1) elem_adj(:,4) elem_adj(:,8) elem_adj(:,5); ...
        elem_adj(:,2) elem_adj(:,3) elem_adj(:,7) elem_adj(:,6); ...
        elem_adj(:,1) elem_adj(:,4) elem_adj(:,3) elem_adj(:,2); ...
        elem_adj(:,5) elem_adj(:,8) elem_adj(:,7) elem_adj(:,6)];
       F_trian = [];  

end
F = [F_trian; F_quad];
%F = sort(F,2);
%F = shift_left(F);
F = sort(F,2);

[F,~,ic] = unique(F,'rows');
fElem_bool = sparse(ic,elem_ind, true);

ref_inedge = sum(fElem_bool,2) == 2;
ref_bedge = sum(fElem_bool,2) == 1;

[elem_bneigh,~] = find(fElem_bool(ref_bedge,:)');
bedge = [F(ref_bedge,:) elem_bneigh];

[elem_ineigh,lines] = find(fElem_bool(ref_inedge,:)');
[~ , sort_ref] = sort(lines);
%lines = lines(sort_ref);
elem_ineigh =  elem_ineigh(sort_ref,:);
elem_ineigh = reshape(elem_ineigh',2,[])';
inedge = [F(ref_inedge,:) elem_ineigh];
[centelem]  = findcentelem(coord, elem(:,1:end-1));
[elemvolume] = volume_tetrahedron(coord,elem);
[baux] = sort(bedgeref(:,1:3),2);
[~,ref] = sortrows(baux,2);
bedge = [bedge bedgeref(ref,end)];

end