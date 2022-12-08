function [elemloc,centers,faces,face_centers] = create_primal_coarse_entities(bkgrid)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
[elemloc] = create_primalcoarse_volumes(bkgrid);
% finding the centers of the primal coarse volume
[centers] = define_pcenters(bkgrid,elemloc);
% defining primal coarse faces
[faces] = create_coarse_face(bkgrid,elemloc);
[face_centers] = create_coarse_face_centers(bkgrid, faces);
end