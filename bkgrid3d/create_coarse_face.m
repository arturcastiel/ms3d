function [coarse_faces] = create_coarse_face(bkgrid, elemloc)
%create_coarse_face creates the coarse faces equivalents of the background
% grid face.
global face
n = size(bkgrid.face_neighbours,1);
inedge = [face.inner.montelem face.inner.juselem];
bedge = face.bound.montelem;
loc_inedge = elemloc(inedge);
loc_bedge = elemloc(bedge);
ref_dif = loc_inedge(:,1) ~= loc_inedge(:,2);
num_fine_internal = size(face.inner.juselem,1);
num_fine_faces = size(face.inner.juselem,1) + size(face.bound.montelem,1);
npar = size(bkgrid.elem,1);
coarse_faces = false(num_fine_faces, npar);
for ii = 1:n
    aux = bkgrid.face_neighbours(ii,:);
    c1 = aux(1);
    c2 = aux(2);
    if c2 ~= 0
        ref1 = all(ismember(loc_inedge, [c1,c2]),2);
        ref = ref1 & ref_dif;
        coarse_faces(find(ref),ii) = true;
    else
        ref = loc_bedge == c1;
        normals = bkgrid.face_normals(ii,:);
        fcenter = bkgrid.face_center(ii,:);    
        refn = is_on_plane(face.bound.centroid(ref,:), normals, fcenter);
        ref(ref==true) = refn;
        coarse_faces(find(ref)+ num_fine_internal ,ii) = true;
    end


end

end