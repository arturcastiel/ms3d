function [inv_dist] = dist_vec_pseudovec(nodes_around_elem, ref, ...
                                                    coord, elem_centroid)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
node_coord = coord(ref,:);
inv_dist = zeros(size(nodes_around_elem));
for index = 1:size(nodes_around_elem,2)
    local_elem_centroid = elem_centroid(nodes_around_elem(:,index),:);
    dist = vecnorm((node_coord - local_elem_centroid),2,2);
    inv_dist(:,index) = (1./ dist);
end
    inv_dist = sum(inv_dist,2).\inv_dist;
end