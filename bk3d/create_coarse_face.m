function [coarse_faces] = create_coarse_face(bkgrid, pcoarse)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
global element face
n = size(bkgrid.face_neighbours,1);
inedge = [face.inner.montelem face.inner.juselem];
loc_inedge = pcoarse.elemloc(inedge);
ref_dif = loc_inedge(:,1) ~= loc_inedge(:,2);
num_fine_internal = size(face.inner.juselem,1);
num_fine_faces = size(face.inner.juselem,1) + size(face.bound.montelem,1);
npar = size(bkgrid.elem,1);
coarse_faces = sparse(num_fine_faces, npar);
for ii = 1:n
    flag = bkgrid.bfaces(ii);
    if flag == 0
        aux = bkgrid.face_neighbours(ii,:);
        c1 = aux(1);
        c2 = aux(2);
        ref1 = all(ismember(loc_inedge, [c1,c2]),2);
        ref = ref1 & ref_dif;
        coarse_faces(find(ref),ii) = 1;
    else
        1%ref = inner_coarse_faces ;

    end


end

end