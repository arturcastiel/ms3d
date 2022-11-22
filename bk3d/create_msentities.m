function [coord, elem, F, fElem, bfaces] = create_msentities(file_coarse)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
%%creating background grid
bkgrid = struct
[bkgrid.coord, bkgrid.elem, bkgrid.faces_adj, bkgrid.elem_faces, bkgrid.bfaces, ...
    bkgrid.element_center, bkgrid.face_center, bkgrid.face_neighbours]  = read_bkgrid(file_coarse);
%% creating primal coarse grid entities
pcoarse = struct
[pcoarse.elemloc] = create_primalcoarse_volumes(bkgrid);
% finding the centers of the primal coarse volume
[pcoarse.centers] = define_pcenters(bkgrid,pcoarse.elemloc);
% defining primal coarse faces
create_coarse_face(bkgrid,pcoarse)
postprocessor3D( pcoarse.elemloc, 'primal', 1 );
%postprocessor3D( pcoarse.elemloc - elemloc2, 'diff', 1 );

end