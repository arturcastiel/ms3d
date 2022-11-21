function [coord, elem, F, fElem, bfaces] = create_msentities(file_coarse)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
%%creating background grid
bkgrid = struct
[bkgrid.coord, bkgrid.elem, bkgrid.faces, bkgrid.elem_faces, bkgrid.bfaces, ...
    bkgrid.element_center, bkgrid.face_center]  = read_bkgrid(file_coarse);
%% creating primal coarse candidate
[outputArg1,outputArg2] = create_primalcoarse(bkgrid)
end