function [sub_faces] = create_sub_faces(bkgrid, pcoarse, mesh)
%create_dual_faces Function that creates the sub_faces of the dual coarse
%grid
sub_faces = false(size(pcoarse.elemloc,1),size(bkgrid.edges,1));
%% creating the sub_faces
for index_edge = 1:size(bkgrid.edges,1)
    edge_center = bkgrid.edge_centers(index_edge,:);
    around_edge_volumes = any(bkgrid.elem_edges == index_edge,2);
    for vol = find(around_edge_volumes)'
        %vol = around_edge_volumes(index_vol);
        mref = pcoarse.elemloc == vol;
        vol_center = bkgrid.element_center(vol,:);
        vol_faces = bkgrid.elem_faces(vol,:)';
        vol_faces_sharing_index_edge = ...
            any(bkgrid.face_edges(vol_faces,:) == index_edge,2);
        face_volumes = vol_faces(vol_faces_sharing_index_edge);
        shared_faces_center = bkgrid.face_center(face_volumes,:);        
        plane = [edge_center; shared_faces_center(1,:); vol_center; ...
            shared_faces_center(2,:);];
        plane_normal = cross(plane(2,:) - plane(1,:), ...
            plane(3,:) - plane(1,:));
        plane_center = mean(plane);
        %%
        ref_elem = plane_boundbox(plane, plane_normal, plane_center, ...
            mesh.element.centroid(mref,:));
        mref(mref) = ref_elem;        
        fsvol_adj = mesh.element.vertices(mref,:);
        list_local_nodes = setdiff(unique(fsvol_adj),0);
        local_coords = mesh.vertex.coord(list_local_nodes,:);
        node_analyzes = zeros(max(list_local_nodes),1);
        node_analyzes(list_local_nodes) = 1;
        [nodes_ref] = is_split_by_plane(local_coords, plane_normal , ...
            plane_center);
        node_analyzes(node_analyzes ~=0 ) = nodes_ref;
        map_vol_adj = mask_matrix(fsvol_adj, node_analyzes);
        ref_vol1 = any(map_vol_adj == 1,2);
        ref_vol2 = any(map_vol_adj == 2,2);
        lcref = ref_vol1 & ref_vol2;
        mref(mref==1) = lcref;
        sub_faces(:,index_edge) = sub_faces(:,index_edge) | mref;
    end    
end
%integrity test on sub_faces
[sub_faces] = integrity_face(sub_faces, mesh);
end


