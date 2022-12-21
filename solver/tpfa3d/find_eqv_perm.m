function [k_eq] = find_eqv_perm(k_left,k_right, h_left, h_right, areas)
        k_eq = ((k_right.*k_left)./...
            (k_right.*h_left+k_left.*h_right)).*areas;
end