function [boundary_support] = create_boundary_support_region_speed( ...
    bkgrid, sub_faces)
%UNTITLED18 Summary of this function goes here
%   Detailed explanation goes here
global element
boundary_support = false(size(element.volume,1), size(bkgrid.elem,1));
%% creating boundaries of the support region of excluding the boundary that
% connect to the boundaries of the domain
for vol = 1:size(bkgrid.elem,1)
    list_nodes = bkgrid.elem(vol,:);
    list_nodes = list_nodes(list_nodes ~=0 );
    list_edges = bkgrid.elem_edges(vol,:);
    list_edges = list_edges(list_edges ~= 0);
    refd = setdiff(find(any(ismember(bkgrid.edges,list_nodes),2)),list_edges);
    boundary_support(:, vol) = any(sub_faces(:,refd),2);
end
end