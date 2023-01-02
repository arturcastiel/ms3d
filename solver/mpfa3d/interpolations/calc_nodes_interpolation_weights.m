function [weights] = calc_nodes_interpolation_weights(mesh, preconfig)
switch  preconfig.interpolaton_type
    case 1
        disp("Using inverse distance interpolation algorithm.")
        [weights] = calc_inv_dist_weight(mesh);
    otherwise
        error("ERROR: Weight type not identified.")
end
end