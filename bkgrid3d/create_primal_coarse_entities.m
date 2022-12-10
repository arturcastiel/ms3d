function [elemloc,centers,faces,face_centers] = ...
                        create_primal_coarse_entities(bkgrid, msconfig)
%create_primal_coarse_entities Function that creates the primal coarse
% mesh elements
[elemloc] = create_primalcoarse_volumes(bkgrid);
% finding the centers of the primal coarse volume
[centers] = define_pcenters(bkgrid,elemloc);
% defining primal coarse faces
[faces] = create_coarse_face(bkgrid,elemloc);
[face_centers] = create_coarse_face_centers(bkgrid, faces);
if msconfig.sparse_structures
    [faces] = sparse(faces);
end
end