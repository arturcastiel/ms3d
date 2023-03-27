function  [mesh, multiscale_mesh] = build_simulation(preconfig,msconfig)
solver = struct();
%% building mesh and multiscale mesh
[mesh, multiscale_mesh] = build_simulation_meshes(preconfig,msconfig);
toc
%% building the pressure solver parameters) - mpfad-3d entities
[solver.pressure_param] = build_mpfad3d_properties(mesh, preconfig);
%% creating face transmissibility matrices
[face_trans, face_source] = ...
                        create_face_transmissibility_matrix(mesh, solver);


%% creating summation operator
[summation]= create_summation_operator(mesh);
M = summation*face_trans;
F = summation*face_source + mesh.physical_properties.element.source;
[p] = ssolver(M,F);
flow = face_trans *p -  face_source;
mass_balance = summation*flow + mesh.physical_properties.element.source;
%tic;write_vtk([p],["mpfad"], 3, false, pwd, "pressure_artur", mesh,0);toc
% name = cellstr(preconfig.mesh_file);
% name = name{1};
% 
% %% multiscale manipulation
% RO = generate_restriction(multiscale_mesh);
% PO = generate_prolongation_msrst(mesh, multiscale_mesh, RO', M, 2/3,300);
% opname = []
% for ii = 1:size(RO,1)
%     nnmae = sprintf("OP-%d", ii);
%     opname = [opname, nnmae];
% end
% write_vtk([RO'],opname, 3, false, pwd, "restriction", mesh, str2num(name(end-4)));
% write_vtk([PO],opname, 3, false, pwd, "prolongation", mesh, str2num(name(end-4)));
% 
% 
% toc
% write_vtk([p],["mpfad"], 3, false, pwd, "pressure_speed", mesh, str2num(name(end-4)));

size(mesh.element.centroid)
1
% 
% %p2 = M\F;
% 
% flow = face_trans *p -  face_source;
% mass_balance = summation*flow + mesh.physical_properties.element.source;
% toc
% name = cellstr(preconfig.mesh_file);
% name = name{1};
% disp(name)
% 1
% % tic
% % p2 = M\F;
% % toc
% tic;write_vtk([p],["mpfad"], 3, false, pwd, "pressure_test", mesh,str2num(name(end-4)));toc
% 
% %tic;write_vtk([p p2 p2-p],["mpfad" "mpfan" "error"], 3, false, pwd, "pressure_test", mesh,str2num(name(end-4)));toc
% 1
% %debug_mpfad3d2
% %2

end