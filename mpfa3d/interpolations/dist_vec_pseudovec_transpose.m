function [inv_dist] = dist_vec_pseudovec_transpose(elem_around_nodes,...
                                                 ref, coord, elem_centroid)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
local_elem_centroid = elem_centroid(ref,:);
inv_dist = zeros(size(elem_around_nodes));
for index = 1:size(elem_around_nodes,2)
    nodes_coord = coord(elem_around_nodes(:,index),:);
    dist = vecnorm((local_elem_centroid - nodes_coord),2,2);
    inv_dist(:,index) = (1./ dist);
end
end