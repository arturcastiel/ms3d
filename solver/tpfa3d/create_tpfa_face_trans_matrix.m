function [trans_tpfa, face_source_tpfa] = ...
                                    create_tpfa_face_trans_matrix(mesh)
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here
num_inner_faces = size(mesh.face.inner.centroid,1);
num_bound_faces = size(mesh.face.bound.centroid,1);
inner_count = [1:num_inner_faces]';
bound_count = [1:num_bound_faces]' + num_inner_faces;
auxmat = [[inner_count mesh.face.inner.upstream ...
          mesh.pressure_solver_param.inner.t_eq];
          [inner_count mesh.face.inner.downstream ...
          -mesh.pressure_solver_param.inner.t_eq];
          [bound_count mesh.face.bound.upstream ...
          mesh.pressure_solver_param.bound.t_eq]];
trans_tpfa = sparse(auxmat(:,1), auxmat(:,2),auxmat(:,3));

aux_face_adj = [mesh.face.inner.vertices ; mesh.face.bound.vertices];
p_gv = mesh.pressure_solver_param.p_dir(aux_face_adj);
temp =  mesh.pressure_solver_param.inner.gv;
temp(:) = 0;
GV =  [ temp;  ...
        mesh.pressure_solver_param.bound.gv];
K =  - [sum(temp,2); ...
       mesh.pressure_solver_param.bound.t_eq];
%count_faces = [1:size(aux_face_adj,1)]';
% transm = [-mesh.pressure_solver_param.inner.t_eq .* ...
%            mesh.pressure_solver_param.inner.gv;     ...
%           -mesh.pressure_solver_param.bound.t_eq .* ...
%                         zeros(size(mesh.pressure_solver_param.bound.gv))];
transm = K.*GV.*p_gv;
face_source_tpfa = sum(transm,2);


end