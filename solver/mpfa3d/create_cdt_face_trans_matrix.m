function [face_trans_cdt, face_source_cdt] = ...
                            create_cdt_face_trans_matrix(mesh, solver)
weights = solver.pressure_param.vertex.weights;
aux_face_adj = [mesh.face.inner.vertices ; mesh.face.bound.vertices];
aux_face_p_gev_ref = solver.pressure_param.p_dir_ref(aux_face_adj);
p_gv = solver.pressure_param.p_dir(aux_face_adj);
temp =  solver.pressure_param.bound.gv;
temp(:) = 0;
GV =  [ solver.pressure_param.inner.gv;  ...
        temp];
K =   [solver.pressure_param.inner.t_eq; ...
       solver.pressure_param.bound.t_eq];
count_faces = uint32([1:size(aux_face_adj,1)]');
transm = K.*GV;
transm2 = transm;
transm2(~aux_face_p_gev_ref) = 0;
face_source_cdt = sum(transm2 .*p_gv,2);

transm(aux_face_p_gev_ref) = 0;
face_node_transm = ...
        sparse(repmat(count_faces,3,1),reshape(aux_face_adj,[],1), ...
        reshape(transm,[],1));
face_trans_cdt = -face_node_transm * weights;
% fcdt_i = weights(aux_face_adj(:,1),:).* transm(:,1);
% fcdt_j = weights(aux_face_adj(:,2),:).* transm(:,2);
% fcdt_k = weights(aux_face_adj(:,3),:).* transm(:,3);
% 
% face_trans_cdt = (fcdt_i + fcdt_j + fcdt_k);

%face_trans_cdt = -face_node_transm * weights;
end