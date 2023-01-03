function  [mesh, multiscale_mesh] = build_simulation(preconfig,msconfig)

%% building mesh and multiscale mesh
[mesh, multiscale_mesh] = build_simulation_meshes(preconfig,msconfig);
%% building the pressure solver parameters) - mpfad-3d entities
[mesh.pressure_solver_param] = build_mpfad3d_properties(mesh, preconfig);
%% creating face transmissibility matrices
out = create_face_transmissibility_matrix(mesh);
%% creating summation operator
%[summation]= create_summation_operator(mesh);
1


end