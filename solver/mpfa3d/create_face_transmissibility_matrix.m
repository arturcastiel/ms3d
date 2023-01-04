function [face_trans] = create_face_transmissibility_matrix(mesh)
%% debug
[summation]= create_summation_operator(mesh);
debug_pesos_mpfad
[face_trans_tpfa] = create_tpfa_face_trans_matrix(mesh);
[face_trans_cdt] = create_cdt_face_trans_matrix(mesh, ...
                        mesh.pressure_solver_param.vertex.weights); 

face_trans  = face_trans_tpfa + face_trans_cdt;
debug_mpfad3d


end