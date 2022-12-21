function [boundary_support] = create_boundary_support_region ...
    (bkgrid, mesh, sub_faces)
boundary_support = false(size(mesh.element.volume,1), size(bkgrid.elem,1));
for vol = 1:size(bkgrid.elem,1)
    list_nodes = bkgrid.elem(vol,:);
    list_nodes = list_nodes(list_nodes ~=0 );
    list_edges = bkgrid.elem_edges(vol,:);
    list_edges = list_edges(list_edges ~= 0);
    refd = setdiff(find(any(ismember(bkgrid.edges,list_nodes),2)),list_edges);
    boundary_support(:, vol) = any(sub_faces(:,refd),2);
end
end