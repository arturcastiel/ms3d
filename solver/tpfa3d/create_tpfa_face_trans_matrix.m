function [trans_tpfa] = create_tpfa_face_trans_matrix(mesh)
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
end