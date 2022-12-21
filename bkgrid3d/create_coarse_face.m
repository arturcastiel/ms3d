function [coarse_faces] = create_coarse_face(bkgrid, mesh, elemloc)
%create_coarse_face creates the coarse faces equivalents of the background
% grid face.
n = size(bkgrid.face_neighbours,1);
inedge = [mesh.face.inner.upstream mesh.face.inner.downstream];
bedge = mesh.face.bound.upstream;
loc_inedge = elemloc(inedge);
loc_bedge = elemloc(bedge);
ref_dif = loc_inedge(:,1) ~= loc_inedge(:,2);
num_fine_internal = size(mesh.face.inner.downstream,1);
num_fine_faces = size(mesh.face.inner.downstream,1) + ...
                            size(mesh.face.bound.upstream,1);
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
        refn = is_on_plane(mesh.face.bound.centroid(ref,:), normals, fcenter);
        ref(ref==true) = refn;
        coarse_faces(find(ref)+ num_fine_internal ,ii) = true;
    end


end

end