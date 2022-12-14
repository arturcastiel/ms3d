function [bkgrid, pcoarse, dcoarse] = create_msentities(msconfig, mesh)
%create_msentities Function that create the multiscale entities.
% bkgrid -> background grid
% pcoarse-> primal coarse mesh
% dcoarse-> dual coarse mesh
bkgrid = struct;
[bkgrid.coord, bkgrid.elem, bkgrid.faces_adj, bkgrid.elem_faces, ...
    bkgrid.bfaces, bkgrid.element_center, bkgrid.face_center, ...
    bkgrid.face_neighbours, bkgrid.face_normals, bkgrid.edges, ...
    bkgrid.face_edges, bkgrid.elem_edges, bkgrid.edge_centers]  = ...
    create_bkgrid(msconfig,mesh);
%% creating primal coarse grid entities
pcoarse = struct;
[pcoarse.elemloc,pcoarse.centers,pcoarse.faces,pcoarse.face_centers] = ...
    create_primal_coarse_entities(bkgrid, mesh, msconfig);
%% creating bkdual grid
dcoarse = struct;
[dcoarse.nodes, dcoarse.edges, dcoarse.faces, dcoarse.internals,...
    dcoarse.sub_edges,dcoarse.sub_faces,dcoarse.sub_volumes, ...
    dcoarse.boundary_support, dcoarse.support_region] = ...
    create_dual_coarse_grid(bkgrid, pcoarse, mesh, msconfig);

end