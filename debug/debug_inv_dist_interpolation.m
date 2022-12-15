ii = 4000;
tic
inv_dist = mapped_jagged_array(vertex.node_elem_adj, ...
                    @dist_vec_pseudovec, vertex.coord, element.centroid); 
toc

%% faster way
tic
inv_dist2 = mapped_jagged_array(vertex.node_elem_adj', ...
                    @dist_vec_pseudovec_transpose, vertex.coord, element.centroid)'; 
toc
%%

neigh_elem = find(vertex.node_elem_adj(ii,:));
el_centroids = element.centroid(neigh_elem',:);

cent_node_coord = repelem(vertex.coord(ii,:),size(neigh_elem,2),1);
dis = vecnorm((el_centroids - cent_node_coord),2,2);
inv_local_dis = 1./dis;

inv_local_dis
inv_dist(ii,:)
