function [F,fElem_bool] = create_unique_faces_adj(elem_adj)
%create_unique_faces_adj creates the unique faces using as reference the 
% element_adj that contains a description of tetrahedron elements.
% F does not contain a seperation of inner and boundary faces.
%   OUTPUT:
%   F(i,:) contains the node adjacencies of the face i.
%   fElem_bool(i,j) returns positve if the element j has the face i.
flag = 0;
if all(elem_adj(:,end) == 0)
    elem_adj = elem_adj(:, 1:4);
    flag = 0;
end
%% if flag == 0 , only tetrahedron
% flag == 1, tetrahedron and hexahedron
elem_ind = [1:size(elem_adj,1)]';
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
%%if other meshes with other elements than tetrahedron are used
% shift must adapted and used instead of sort
%F = shift_left(F);
F = sort(F,2);
[F,~,ic] = unique(F,'rows');
fElem_bool = sparse(ic,elem_ind, true);
end