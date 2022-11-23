global element face
ii = 41;
n = size(element.volume,1)
num_inner_faces = size(face.inner.montelem,1);

value = zeros(n,1);
%% testing inner coarse faces
aux = bkgrid.face_neighbours(ii,:);
if aux(2) ~= 0 
    list_faces = pcoarse.face_centers(ii);
    list_el1 = face.inner.juselem(list_faces);
    list_el2 = face.inner.montelem(list_faces);
    list_elements = unique([list_el1 list_el2]);
else
    list_faces = pcoarse.face_centers(ii) - num_inner_faces;
    list_elements = unique(face.bound.montelem(list_faces));
end
    value(list_elements) = 10;

postprocessor3D( value, 'debug_coarse_faces_center', 1 );