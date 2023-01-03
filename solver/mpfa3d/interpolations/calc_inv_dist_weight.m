function [inv_dist] = calc_inv_dist_weight(mesh)
inv_dist = mapped_jagged_array(mesh.vertex.node_elem_adj', ...
    @dist_vec_pseudovec_transpose, mesh.vertex.coord, ...
    mesh.element.centroid)';
el_inv_dist = inv_dist';
sum_rows  = 1./sum(el_inv_dist,2);
inv_dist = (sum_rows .* el_inv_dist)';
end