function [p_dir, ref] = create_dirichlet_pressures_mpfad(mesh)
% creates a vector containing the node based dirichlet bondaries
% conditions
p_dir = sparse(size(mesh.vertex.coord,1),1);
ref = ismember(mesh.vertex.flag, ...
            mesh.physical_properties.flag_value_dirichlet(:,1));
trans_mat = sparse(mesh.physical_properties.flag_value_dirichlet(:,1), ...
    ones(size(mesh.physical_properties.flag_value_dirichlet(:,1))), ...
    mesh.physical_properties.flag_value_dirichlet(:,2));
p_dir(ref) = trans_mat(mesh.vertex.flag(ref));

end