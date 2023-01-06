function [face_trans] = create_face_transmissibility_matrix(mesh)
%% debug
[summation]= create_summation_operator(mesh);

[face_trans_tpfa, face_source_tpfa] = create_tpfa_face_trans_matrix(mesh);
[face_trans_cdt, face_source_cdt] = create_cdt_face_trans_matrix(mesh, ...
                              mesh.pressure_solver_param.vertex.weights); 
face_trans  = face_trans_tpfa + face_trans_cdt;
face_source = face_source_tpfa + face_source_cdt;
M = summation * face_trans;
F = summation * face_source;
p_artur = M\F;
write_vtk([p_artur],["mpfad"], 3, false, pwd, "git_mpfad3d", mesh,1)

debug_mpfad3d
2

end