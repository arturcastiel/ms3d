function [face_centers] = create_coarse_face_centers(bkgrid,faces)
%UNTITLED2 Summary of this function goes here
%   faces = [inner; bound]
global face
n = size(faces,2);
face_centers = zeros(n,1);
num_bound_faces = size(face.bound.montelem,1);
num_inner_faces = size(face.inner.montelem,1);
for ii = 1:n
    flag = bkgrid.bfaces(ii);
    bkcenter = bkgrid.face_center(ii,:);
    if flag == false
        list_faces = faces(:,ii);
        list_faces = list_faces(1:end-num_bound_faces);
        mcenters = face.inner.centroid(list_faces,:);
        %face_centrois =

        %         list_el1 = face.inner.juselem(list_faces);
        %         list_el2 = face.inner.montelem(list_faces);
        %         list_elements = unique([list_el1 list_el2]);
    else
        list_faces = faces(:,ii);
        % fixing the boundary reference [inner bound]
        list_faces = list_faces(end-num_bound_faces+1:end);
        mcenters = face.bound.centroid(list_faces,:);
    end
    dist = distp1pm(bkcenter,mcenters);
    ref = dist == min(dist);
    list_faces(list_faces == true) = ref;
    if sum(ref) == 1
        el_center = find(list_faces);
    else
        el_center = find(list_faces);
        el_center = el_center(1);
    end
    ref_move = flag * num_inner_faces;
    face_centers(ii) = el_center + ref_move;
end
end