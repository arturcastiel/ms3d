function [edges] = create_sub_edges(bkgrid,pcoarse, mesh)
%create_sub_edges Function creates the sub_edges of the dual coarse mesh
edges = false(size(bkgrid.bfaces,1),size(mesh.element.centroid,1))';
num_internal_faces = size(mesh.face.inner.centroid,1);
for bface = 1:size(bkgrid.bfaces,1)
    auxvec = bkgrid.face_neighbours(bface,:);
    coarse_left = auxvec(1);
    coarse_right = auxvec(2);
    analyzed_volumes = ismember(pcoarse.elemloc,auxvec);
    analyzed_faces = unique(mesh.element.faces(analyzed_volumes,:));
    left_fine_center_coord = mesh.element.centroid(...
            pcoarse.centers(coarse_left),:);
    if coarse_right ~=0
        right_fine_center_coord = mesh.element.centroid(...
            pcoarse.centers(coarse_right),:);
    else
        fine_face_center = pcoarse.face_centers(bface,:);
        if fine_face_center > num_internal_faces
            right_fine_center_coord = ...
                mesh.face.bound.centroid(fine_face_center - ...
                                    num_internal_faces,:);
        else
            right_fine_center_coord = ...
                mesh.face.inner.centroid(fine_face_center,:);
        end
    end
    reff = check_if_line_crosses_plane(analyzed_faces, ...
                      left_fine_center_coord, right_fine_center_coord, ... 
                                                 mesh.face, mesh.vertex);
    refv = any(ismember(mesh.element.faces(analyzed_volumes,:), ...
                                       analyzed_faces(reff)),2);
    analyzed_volumes(analyzed_volumes) = refv;
    edges(:,bface) = edges(:,bface) | analyzed_volumes;
end

end