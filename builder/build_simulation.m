function  [mesh, multiscale_mesh] = build_simulation(preconfig,msconfig)

%% building mesh and multiscale mesh
[mesh, multiscale_mesh] = build_simulation_meshes(preconfig,msconfig);
%% building mpfad-3d entities
[mesh.mpfad_pararmeters] = build_mpfad3d_properties(mesh, preconfig);

%% creating summation operator
[summation]= create_summation_operator(mesh);


end