function [F_bound_adj, F_bound_neigh, F_bound_flag, F_inner_adj, ...
 F_inner_neigh ] = split_bond_inner_find_face_neigh(F,fElem_bool,bedgeref)
%split_bond_inner_find_face_neigh Split the inner and boundary faces 
%adjacencies in F,  and uses fElem to find the control volumes sharing a  
%a face, i.e. , the faces neighbours.
ref_inedge = sum(fElem_bool,2) == 2;
ref_bedge = sum(fElem_bool,2) == 1;
[elem_bneigh,~] = find(fElem_bool(ref_bedge,:)');
%bedge = [F(ref_bedge,:) elem_bneigh];
F_bound_adj = F(ref_bedge,:);
F_bound_neigh = elem_bneigh;
[baux] = sort(bedgeref(:,1:3),2);
[~,ref] = sortrows(baux,2);
F_bound_flag = bedgeref(ref,end);
[elem_ineigh,lines] = find(fElem_bool(ref_inedge,:)');
[~ , sort_ref] = sort(lines);
elem_ineigh =  elem_ineigh(sort_ref,:);
F_inner_neigh = reshape(elem_ineigh',2,[])';
F_inner_adj = F(ref_inedge,:) ;
%F_inner_neigh = elem_ineigh;
%inedge = [F(ref_inedge,:) elem_ineigh];
end