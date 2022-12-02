global face element

ii = 1;
nodes = element.vertices(ii,:);
faces = element.faces(ii,:);
nodes_faces = unique(face.inner.vertices(faces,:));

