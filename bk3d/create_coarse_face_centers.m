function [face_centers] = create_coarse_face_centers(pcoarse, bkgrid)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
global face
n = size(pcoarse.faces,2);
face_centers = zeros(n,1);
num_bound_faces = size(face.bound.montelem,1);
num_inner_faces = size(face.inner.montelem,1);
for ii = 1:n
    flag = bkgrid.bfaces(ii);
    bkcenter = bkgrid.face_center(ii,:);
    if flag == false
        list_faces = pcoarse.faces(:,ii);
        list_faces = list_faces(1:end-num_bound_faces);
        mcenters = face.inner.centroid(list_faces,:);
        %face_centrois =

        %         list_el1 = face.inner.juselem(list_faces);
        %         list_el2 = face.inner.montelem(list_faces);
        %         list_elements = unique([list_el1 list_el2]);
    else
        list_faces = pcoarse.faces(:,ii);
        % fixing the boundary reference [inner bound]
        list_faces = list_faces(end-num_bound_faces+1:end);
        mcenters = face.bound.centroid(list_faces,:);
    end
    dist = distp1pm(bkcenter,mcenters);
    ref = dist == min(dist);
    if sum(ref) == 1
        el_center = find(ref);
    else
        el_center = find(ref);
        el_center = el_center(1);
    end
    ref_move = flag * num_inner_faces;
    face_centers(ii) = el_center + ref_move;
end
end