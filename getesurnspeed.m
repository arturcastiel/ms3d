function [ esurn1, esurn2 ] =  getesurnspeed(elem)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
elem_ind = [1:size(elem,1)]';
aux = [elem_ind elem(:,1); elem_ind elem(:,2); elem_ind elem(:,3); elem_ind elem(:,4)];
node_elem = sparse(aux(:,2), aux(:,1), true);
[esurn1,~] = find(node_elem');
num_neigh_elem = sum(node_elem,2);
esurn1 = esurn1';
esurn2 = full(cumsum(num_neigh_elem));
esurn2 = [1 (esurn2(1:end-1)'+1)];
end