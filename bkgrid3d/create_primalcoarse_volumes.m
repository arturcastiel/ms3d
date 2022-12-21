function [cloc] = create_primalcoarse_volumes(bkgrid, mesh)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
[cloc] = primal_candidate(bkgrid, mesh);
% functions that ensures pcoarse.cloc volumes are face connected
[cloc] = ensure_cover(cloc, mesh);
%[cloc] = ensure_face_connectivity(cloc);
[cloc] = integrity_face_color_array(cloc, mesh);
end


function [cloc] = primal_candidate(bkgrid, mesh)
    nel = size(bkgrid.elem,1);
    cloc = zeros(size(mesh.element.vertices,1),1);
    normals = bkgrid.face_normals;
    for ii = 1:nel
            faces = bkgrid.elem_faces(ii,:);
            faces = faces(faces ~=0);
            faces_normals = normals(faces',:);
            %node_face_coords = vertex.coord(faces)
            ref = bound_box(mesh.element.centroid, ...
                      bkgrid.coord(unique(bkgrid.faces_adj(faces,:)),:),0);
            ref_loc = inVol3d(mesh.element.centroid(ref,:), ...
                faces_normals,bkgrid.face_center(faces,:), ...
                bkgrid.element_center(ii,:));
            ref(ref) = ref_loc;
            cloc(ref) = ii;

    end
end