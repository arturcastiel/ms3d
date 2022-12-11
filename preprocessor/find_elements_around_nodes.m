function [esurn1, esurn2, node_elem] =  find_elements_around_nodes(elem)
%find_elements_around_nodes Find elements around nodes according to the 
% adjancency matrix elem
% OUTPUT:
%   esurn1 is a flat array containing in order the neighbours of all nodes
%   in the elem adjacency matrix.
%   esurn2 -> vector containing the position of the node neighbours 
%   in esurn1.
%   node_elem  -> bool sparse matrix where node_elem(i,j) is true if the
%   element j contains node i.
elem_ind = [1:size(elem,1)]';
aux = [elem_ind elem(:,1); elem_ind elem(:,2); elem_ind elem(:,3); elem_ind elem(:,4)];
node_elem = sparse(aux(:,2), aux(:,1), true);
[esurn1,~] = find(node_elem');
num_neigh_elem = sum(node_elem,2);
esurn1 = esurn1';
esurn2 = full(cumsum(num_neigh_elem));
esurn2 = [1 (esurn2(1:end-1)'+1)];
end