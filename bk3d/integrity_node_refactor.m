function [loc_elem] = integrity_node_refactor(loc_elem)
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here
global face element
elem_nodes = setdiff(unique(element.vertices(loc_elem,:)),0);
elem_neigh_by_node = any(ismember(element.vertices,elem_nodes),2);
elem_neigh_by_node(loc_elem) = 0;
auxmat = element.vertices(elem_neigh_by_node,:);
bnodes = unique(face.bound.vertices);
auxmat1 = ismember(auxmat, bnodes);
% ref1 = sum(auxmat1,2) == 2;
% ref2 = sum(auxmat2,2) == 3;
auxmat2 = ismember(auxmat, setdiff(elem_nodes,bnodes));
auxmat = auxmat1 + auxmat2;
loc_elem(elem_neigh_by_node) = all(auxmat,2);
% region_internal_nodes = unique(element.vertices(loc_elem,:));
% auxmat1 = ismember(element.vertices,bnodes);
% auxmat2 = ismember(element.vertices,region_internal_nodes);
% auxmat = auxmat1* 2 + 1;
% ref1 = any(auxmat1,2);
% ref2 = any(auxmat2,2);
% refr = ref1&ref2;
% auxmat(~refr,:) = 0;
% ref = (sum(auxmat,2) >2);
% ref(loc_elem) = 1;
% % 
% loc = sort([bnodes ; region_internal_nodes]);
% node_adj= ismember(element.vertices,loc);
% node_sum = sum(node_adj,2);
% 
% ref = sum(ref,2) >=3;
% ref = ref & refr;
end