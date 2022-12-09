function[dual_faces,dual_vol_face_index] = ...
    create_semifaces(bkgrid,pcoarse)
global element vertex
all_faces = false(size(bkgrid.element_center,1),1);
num_semifaces = sum(sum(bkgrid.elem_edges ~=0));
dual_vol_face_index = zeros(num_semifaces,3+1);
dual_face_ref = zeros(num_semifaces,2);
dual_faces = false(size(element.volume,1), num_semifaces);
index = 1;
%% creating the semifaces
for vol = 1:size(bkgrid.elem,1)
    vol_center = bkgrid.element_center(vol,:);
    list_edges = bkgrid.elem_edges(vol,:);
    list_edges = list_edges(list_edges ~= 0);
    list_faces = bkgrid.elem_faces(vol,:);
    list_faces = list_faces(list_faces ~= 0);
    mref = pcoarse.elemloc == vol;
    for edge = list_edges
        if edge ~= 0
            cmref = mref;
            edge_center = bkgrid.edge_centers(edge,:);
            list_faces_sharing_edge = ...
                intersect(find(any(bkgrid.face_edges == edge,2)),list_faces);
            shared_faces_center = ...
                bkgrid.face_center(list_faces_sharing_edge,:);
            plane = [edge_center; shared_faces_center(1,:); vol_center; ...
                shared_faces_center(2,:);];
            plane_normal = cross(plane(2,:) - plane(1,:), ...
                plane(3,:) - plane(1,:));
            plane_center = mean(plane);
            %%
            ref_elem = plane_boundbox(plane, plane_normal, plane_center, ...
                element.centroid(mref,:));
            cmref(cmref == 1) = ref_elem;
            fsvol_adj = element.vertices(cmref,:);
            list_local_nodes = setdiff(unique(fsvol_adj),0);
            local_coords = vertex.coord(list_local_nodes,:);
            node_analyzes = zeros(max(list_local_nodes),1);
            node_analyzes(list_local_nodes) = 1;
            [nref] = is_split_by_plane(local_coords, plane_normal , ...
                plane_center);
            node_analyzes(node_analyzes == 1) = nref;
            map_vol_adj = mask_matrix(fsvol_adj, node_analyzes);
            ref_vol1 = any(map_vol_adj == 1,2);
            ref_vol2 = any(map_vol_adj == 2,2);
            lcref = ref_vol1 & ref_vol2;
            cmref(cmref==1) = lcref;
            dual_faces(:,index) = cmref;
            %debug_dualface
            employed_volumes = ...
                setdiff(unique(bkgrid.face_neighbours(list_faces_sharing_edge,:)),vol)';
            dual_face_ref(index,:) = list_faces_sharing_edge';
            if employed_volumes == 0
                dual_vol_face_index(index,1) = vol;
                dual_vol_face_index(index,end) = edge;
            else
                dual_vol_face_index(index,1:((size(employed_volumes,2))+2)) = [vol employed_volumes edge];
            end
            all_faces(cmref) = 1;
            index = index + 1;
        end
    end
end
end



function [map] = mask_matrix(matrix, mvec)
ref = matrix(:,end) == 0;
matrix(ref,1:3) = mvec(matrix(ref,1:3));
matrix(~ref,:) = mvec(matrix(~ref,:));
map = matrix;
end

