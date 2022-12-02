function [outputArg1,outputArg2] = create_bkdual(bkgrid, pcoarse)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
global element vertex
all_faces = false(size(bkgrid.element_center,1),1);

num_semifaces = sum(sum(bkgrid.elem_edges ~=0));
dual_vol_face_index = zeros(num_semifaces,3+1);
dual_faces = false(size(element.volume,1), num_semifaces);
boundary_support = false(size(element.volume,1), size(bkgrid.elem,1));
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
%             %% ajustar aqui para terminar a escolha das faces
%             ref = plane_boundbox(plane, plane_normal, plane_center, ...
%                 local_coords);
            
            %%
            %node_analyzes(node_analyzes == 1) = ref;
                %is_split_by_plane(plane, fsvol_adj, vertex.coord)
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
%% checking integrity of semifaces

for ii = 1:size(dual_faces,2)
%      dual_faces(:,ii) = integrity_face_refactor(dual_faces(:,ii));
%      dual_faces(:,ii) = integrity_node_refactor(dual_faces(:,ii));
%       dual_faces(:,ii) = integrity_nodeclean(dual_faces(:,ii));
%       dual_faces(:,ii) = integrity_faceclean(dual_faces(:,ii));
%       dual_faces(:,ii) = integrity_node(dual_faces(:,ii));
%       dual_faces(:,ii) = integrity_face(dual_faces(:,ii));
end


%% creating boundaries of the support region of excluding the boundary that
% connect to the boundaries of the domain
for vol = 1:size(bkgrid.elem,1)
    list_edges = bkgrid.elem_edges(vol,:);
    list_edges = list_edges(list_edges ~= 0);
    node_neighbours = setdiff(bkgrid.elem(vol,:),0);
    vol_neighbours = any(ismember(bkgrid.elem,node_neighbours),2);
    vol_neighbours(vol) = false;
    semi_faces_in_support = all(ismember(dual_vol_face_index(:,1:3),find(vol_neighbours)),2);
    ref = ~ismember(dual_vol_face_index(:,end),list_edges);
    semi_faces_in_support = semi_faces_in_support & ref;
    for face = find(semi_faces_in_support)'
        boundary_support(:, vol) = boundary_support(:, vol) | dual_faces(:,face) ;
    end
end

%% adding to the boundary of the support region the faces that connect to
% boundaries of the domain
% this has been split for the sake of simplicty in cases we relocate the
% coarse volume centers

boundary_element = setdiff(unique(bkgrid.face_neighbours(bkgrid.bfaces,:)),0)';
boundary_nodes = unique(bkgrid.faces_adj(bkgrid.bfaces,:));
boundary_edges = find(all(ismember(bkgrid.edges,boundary_nodes),2));


for vol = boundary_element
    list_edges = bkgrid.elem_edges(vol,:);
    list_edges = list_edges(list_edges ~= 0);    
    boundary_edges = intersect(list_edges, boundary_edges);    
    %ref_edges_include = ismember(dual_vol_face_index(:,end), boundary_edges);
    node_neighbours = setdiff(bkgrid.elem(vol,:),0);
    node_neighbours = intersect(node_neighbours,boundary_nodes)';
    vol_neighbours = any(ismember(bkgrid.elem,node_neighbours),2);
    vol_neighbours(vol) = false;
    vol_neighbours = [find(vol_neighbours)];
    ref_notself = any(dual_vol_face_index(:,1:3) ~= vol,2);
    ref_vol_neigh = any(ismember(dual_vol_face_index(:,1:3),vol_neighbours),2);
    auxmat = (bkgrid.edges(dual_vol_face_index(:,end),:));
    auxmat = ismember(auxmat,node_neighbours);
    auxmat = xor(auxmat(:,1),auxmat(:,2));
    ref_edges = ~ismember(dual_vol_face_index(:,end),list_edges);
    ref = ref_notself & ref_vol_neigh & auxmat & ref_edges;
    semi_faces_in_support = find(ref)';
    for face = semi_faces_in_support
        boundary_support(:, vol) = boundary_support(:, vol) | dual_faces(:,face) ;
    end
end
1


for ii = 1:size(boundary_support,2)
%      boundary_support(:,ii) = integrity_face_refactor(boundary_support(:,ii));
%      boundary_support(:,ii) = integrity_node_refactor(boundary_support(:,ii));
%       dual_faces(:,ii) = integrity_nodeclean(dual_faces(:,ii));
%      boundary_support(:,ii) = integrity_faceclean(boundary_support(:,ii));
%       dual_faces(:,ii) = integrity_node(dual_faces(:,ii));
%       dual_faces(:,ii) = integrity_face(dual_faces(:,ii));
end


postprocessor3D( dual_faces(:,35), 'all_faces', 1 );
outputArg1 = inputArg1;
outputArg2 = inputArg2;
end

function [map] = mask_matrix(matrix, mvec)
ref = matrix(:,end) == 0;
matrix(ref,1:3) = mvec(matrix(ref,1:3));
matrix(~ref,:) = mvec(matrix(~ref,:));
map = matrix;
end



