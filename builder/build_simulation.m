function  [mesh, multiscale_mesh] = build_simulation(preconfig,msconfig)

%% building mesh and multiscale mesh
tic
[mesh, multiscale_mesh] = build_simulation_meshes(preconfig,msconfig);
toc
%% building the pressure solver parameters) - mpfad-3d entities
[mesh.pressure_solver_param] = build_mpfad3d_properties(mesh, preconfig);
%% creating face transmissibility matrices
[face_trans, face_source] = create_face_transmissibility_matrix(mesh);
%% creating summation operator
[summation]= create_summation_operator(mesh);
M = summation*face_trans;
F = summation*face_source + mesh.physical_properties.element.source;
toc
1
tic; [p] = ssolver(M,F);toc
flow = face_trans *p -  face_source;
mass_balance = summation*flow + mesh.physical_properties.element.source;
toc
% tic
% p2 = M\F;
% toc
write_vtk([p],["mpfad"], 3, false, pwd, "pressure_test", mesh,1)
toc
1
debug_mpfad3d2
2

end