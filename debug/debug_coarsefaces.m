global element face
ii = 41;
n = size(element.volume,1)
value = zeros(n,1);
%% testing inner coarse faces
aux = bkgrid.face_neighbours(ii,:);


if aux(2) ~= 0 
    list_faces = pcoarse.faces(:,ii);
    list_el1 = face.inner.juselem(list_faces);
    list_el2 = face.inner.montelem(list_faces);
    list_elements = unique([list_el1 list_el2]);
else
    list_faces = pcoarse.faces(:,ii);
    num_bound_faces = size(face.bound.montelem,1);
    % fixing the boundary reference [inner bound]
    list_faces = list_faces(end-num_bound_faces+1:end);
    list_elements = unique(face.bound.montelem(list_faces));
end
    value(list_elements) = 10;

postprocessor3D( value, 'debug_coarse_faces', 1 );