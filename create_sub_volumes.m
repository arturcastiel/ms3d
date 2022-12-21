function [sub_volumes] = create_sub_volumes(bkgrid, mesh, pcoarse)
%create_sub_volumes Create the sub_volumes of the dual mesh
%   Each volume is associated with a node in the background grid
sub_volumes = false(size(pcoarse.elemloc,1),size(bkgrid.coord,1));
for node = 1:size(bkgrid.coord,1)
    edges_ref = any(bkgrid.edges == node,2);
    edges_neigh_node = bkgrid.edges(edges_ref,:);
    p1 = bkgrid.coord(edges_neigh_node(:,1),:);
    p2 = bkgrid.coord(edges_neigh_node(:,2),:);
    edge_vec = p2-p1;
    face_normals = edge_vec./vecnorm(edge_vec,2,2);
    face_centers = 0.5*(p1+p2);
    element_center = mean(face_centers);
    center_test_ref = ismember(pcoarse.elemloc, ...
        find(any(bkgrid.elem == node,2)));
    [in_dual] = inVol3d(mesh.element.centroid(center_test_ref,:), ...
                face_normals, face_centers, element_center);
    center_test_ref(center_test_ref) = in_dual;
    sub_volumes(:,node) = center_test_ref;
end
end