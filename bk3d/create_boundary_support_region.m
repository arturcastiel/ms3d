function [boundary_support] = create_boundary_support_region(bkgrid, ...
    dual_vol_face_index, dual_faces)
%UNTITLED18 Summary of this function goes here
%   Detailed explanation goes here
global element
boundary_support = false(size(element.volume,1), size(bkgrid.elem,1));
%% creating boundaries of the support region of excluding the boundary that
% connect to the boundaries of the domain
for vol = 1:size(bkgrid.elem,1)
    list_edges = bkgrid.elem_edges(vol,:);
    list_edges = list_edges(list_edges ~= 0);
    node_neighbours = setdiff(bkgrid.elem(vol,:),0);
    vol_neighbours = any(ismember(bkgrid.elem,node_neighbours),2);
    vol_neighbours(vol) = false;
    semi_faces_in_support = all(ismember(dual_vol_face_index(:,1:3),find(vol_neighbours)),2);
    ref = ~ismember(dual_vol_face_index(:,end),list_edges);
    semi_faces_in_support = semi_faces_in_support & ref;
    for index_face = find(semi_faces_in_support)'
        boundary_support(:, vol) = boundary_support(:, vol) | dual_faces(:,index_face) ;
    end
end

%% adding to the boundary of the support region the faces that connect to
% boundaries of the domain
% this has been split for the sake of simplicty in cases we relocate the
% coarse volume centers

boundary_element = setdiff(unique(bkgrid.face_neighbours(bkgrid.bfaces,:)),0)';
boundary_nodes = unique(bkgrid.faces_adj(bkgrid.bfaces,:));
boundary_edges = find(all(ismember(bkgrid.edges,boundary_nodes),2));


for vol = boundary_element
    list_edges = bkgrid.elem_edges(vol,:);
    list_edges = list_edges(list_edges ~= 0);
    boundary_edges = intersect(list_edges, boundary_edges);
    %ref_edges_include = ismember(dual_vol_face_index(:,end), boundary_edges);
    node_neighbours = setdiff(bkgrid.elem(vol,:),0);
    node_neighbours = intersect(node_neighbours,boundary_nodes)';
    vol_neighbours = any(ismember(bkgrid.elem,node_neighbours),2);
    vol_neighbours(vol) = false;
    vol_neighbours = [find(vol_neighbours)];
    ref_notself = any(dual_vol_face_index(:,1:3) ~= vol,2);
    ref_vol_neigh = any(ismember(dual_vol_face_index(:,1:3),vol_neighbours),2);
    auxmat = (bkgrid.edges(dual_vol_face_index(:,end),:));
    auxmat = ismember(auxmat,node_neighbours);
    auxmat = xor(auxmat(:,1),auxmat(:,2));
    ref_edges = ~ismember(dual_vol_face_index(:,end),list_edges);
    ref = ref_notself & ref_vol_neigh & auxmat & ref_edges;
    semi_faces_in_support = find(ref)';
    for index_face = semi_faces_in_support
        boundary_support(:, vol) = boundary_support(:, vol) | dual_faces(:,index_face) ;
    end
end

end