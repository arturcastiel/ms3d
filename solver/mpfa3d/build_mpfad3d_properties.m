function [mpfad] = build_mpfad3d_properties(mesh, preconfig)
% creating parameters used in the calculation of the MFPA-D 3D
% transmissibility
mpfad = struct;
flagstruct = mesh.physical_properties;
[inner_k_left, inner_k_right, inner_h_left, inner_h_right] = ...
   calc_inner_face_project_permeability(mesh.vertex, mesh.face, ...
                                            mesh.element, flagstruct);
[inner_k_eq] = find_eqv_perm(inner_k_left, inner_k_right, inner_h_left, ...
    inner_h_right, mesh.face.inner.area);
[bound_k_eq, bound_h_left] = calc_bound_face_project_permeability...
                        (mesh.vertex, mesh.face, mesh.element, flagstruct);
[inner_gv] = calc_inner_gvp(mesh.vertex, mesh.face, mesh.element, ...
    inner_k_left, inner_k_right,inner_h_left, inner_h_right, flagstruct);
[bound_gv] =  calc_bound_gvp(mesh.vertex, mesh.face, mesh.element, ...
    bound_h_left, bound_k_eq, flagstruct);
%bound_k_eq = 2*(bound_k_eq ./ bound_h_left);
%mpfad.inner.k_left = inner_k_left;
%mpfad.inner.k_right = inner_k_right;
mpfad.inner.t_eq = inner_k_eq;
mpfad.inner.h_left = inner_h_left;
mpfad.inner.h_right = inner_h_right;
mpfad.inner.gv = inner_gv;
mpfad.bound.t_eq = (mesh.face.bound.area.* bound_k_eq)./bound_h_left;
mpfad.bound.h_left = bound_h_left;
mpfad.bound.gv = bound_gv;
mpfad.vertex.weights = calc_nodes_interpolation_weights(mesh, preconfig);
[mpfad.p_dir, mpfad.p_dir_ref] = create_dirichlet_pressures_mpfad(mesh);
end