function [bkgrid, pcoarse, bkdual] = create_msentities(msconfig)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
%%creating background grid
bkgrid = struct;
[bkgrid.coord, bkgrid.elem, bkgrid.faces_adj, bkgrid.elem_faces, ...
    bkgrid.bfaces, bkgrid.element_center, bkgrid.face_center, ...
    bkgrid.face_neighbours, bkgrid.face_normals, bkgrid.edges, ...
    bkgrid.face_edges, bkgrid.elem_edges, bkgrid.edge_centers]  = ...
    create_bkgrid(msconfig);
%% creating primal coarse grid entities
pcoarse = struct;
[pcoarse.elemloc,pcoarse.centers,pcoarse.faces,pcoarse.face_centers] = ...
    create_primal_coarse_entities(bkgrid);

%% creating bkdual grid
bkdual = struct;
[outputArg1,outputArg2] = create_bkdual(bkgrid, pcoarse);

%postprocessor3D( pcoarse.elemloc, 'primal', 1 );
%postprocessor3D( pcoarse.elemloc - elemloc2, 'diff', 1 );

end