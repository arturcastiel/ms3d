function [cloc] = create_primalcoarse_volumes(bkgrid)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
global vertex element face
[cloc] = primal_candidate(bkgrid);
% functions that ensures pcoarse.cloc volumes are face connected
[cloc] = ensure_cover(cloc);
[cloc] = ensure_face_connectivity(cloc);
end


function [cloc] = primal_candidate(bkgrid)
    global element
    nel = size(bkgrid.elem,1);
    cloc = zeros(size(element.vertices,1),1);
    normals = compute_normals(bkgrid.faces_adj(:,1:3),bkgrid.coord);
    for ii = 1:nel
            faces = bkgrid.elem_faces(ii,:);
            faces = faces(faces ~=0);
            faces_normals = normals(faces',:);
            ref = inVol3d(element.centroid, faces_normals,bkgrid.face_center(faces,:), bkgrid.element_center(ii,:));
            cloc(ref) = ii;

    end
end