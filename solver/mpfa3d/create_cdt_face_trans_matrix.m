function [face_trans_cdt, face_source_cdt] = ...
                            create_cdt_face_trans_matrix(mesh, weights)
aux_face_adj = [mesh.face.inner.vertices ; mesh.face.bound.vertices];
p_gv = mesh.pressure_solver_param.p_dir(aux_face_adj);

temp =  mesh.pressure_solver_param.bound.gv;
temp(:) = 0;
GV =  [ mesh.pressure_solver_param.inner.gv;  ...
        temp];
K =  - [mesh.pressure_solver_param.inner.t_eq; ...
       mesh.pressure_solver_param.bound.t_eq];
count_faces = [1:size(aux_face_adj,1)]';
% transm = [-mesh.pressure_solver_param.inner.t_eq .* ...
%            mesh.pressure_solver_param.inner.gv;     ...
%           -mesh.pressure_solver_param.bound.t_eq .* ...
%                         zeros(size(mesh.pressure_solver_param.bound.gv))];
transm = K.*GV;
face_node_transm = ...
        sparse(repmat(count_faces,3,1),reshape(aux_face_adj,[],1), ...
        reshape(transm,[],1));
face_trans_cdt = face_node_transm * weights;
% t_eq is on the LHS therefore it needs no (-)
% auxmat = -[mesh.pressure_solver_param.bound.t_eq .* p_gv, ...
%     zeros(size(mesh.pressure_solver_param.bound.gv),1)]

%face_source_cdt = sum((-mesh.pressure_solver_param.bound.t_eq .* p_gv),2)
face_source_cdt = -sum(transm .*p_gv,2);

%face_source_cdt = face_node_transm * mesh.pressure_solver_param.p_dir;
end