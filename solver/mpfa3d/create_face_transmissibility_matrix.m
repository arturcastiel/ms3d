function [face_trans, face_source] = create_face_transmissibility_matrix(mesh)
[face_trans_tpfa, face_source_tpfa] = create_tpfa_face_trans_matrix(mesh);
[face_trans_cdt, face_source_cdt] = create_cdt_face_trans_matrix(mesh, ...
                              mesh.pressure_solver_param.vertex.weights); 
face_trans  = face_trans_tpfa + face_trans_cdt;
face_source = face_source_tpfa + face_source_cdt;
end