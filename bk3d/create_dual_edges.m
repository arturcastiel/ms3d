function [edges] = create_dual_edges(bkgrid,pcoarse)
%UNTITLED19 Summary of this function goes here
%   Detailed explanation goes here
global face element
edges = false(size(bkgrid.bfaces,1),size(element.centroid,1))';
num_internal_faces = size(face.inner.centroid,1);
for bface = 1:size(bkgrid.bfaces,1)
    auxvec = bkgrid.face_neighbours(bface,:);
    coarse_left = auxvec(1);
    coarse_right = auxvec(2);
    analyzed_volumes = ismember(pcoarse.elemloc,auxvec);
    %ref = ismember(dual_vol_face_index(:,1),[coarse_left, coarse_right]);
    %analyzed_volumes = any(dual_faces(:,ref),2);
    analyzed_faces = unique(element.faces(analyzed_volumes,:));
    left_fine_center_coord = element.centroid(pcoarse.centers(coarse_left),:);
    if coarse_right ~=0
        right_fine_center_coord = element.centroid(pcoarse.centers(coarse_right),:);
    else
        fine_face_center = pcoarse.face_centers(bface,:);
        if fine_face_center > num_internal_faces
            right_fine_center_coord = ...
                face.bound.centroid(fine_face_center - num_internal_faces,:);
        else
            right_fine_center_coord = ...
                face.inner.centroid(fine_face_center,:);
        end
    end
    reff = check_if_line_crosses_plane(analyzed_faces, ...
        left_fine_center_coord, right_fine_center_coord);
    refv = any(ismember(element.faces(analyzed_volumes,:),analyzed_faces(reff)),2);
    analyzed_volumes(analyzed_volumes) = refv;
    edges(:,bface) = edges(:,bface) | analyzed_volumes;
end

end