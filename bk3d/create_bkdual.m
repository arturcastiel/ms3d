function [nodes,edges, faces, internals, sub_edges, sub_faces,sub_volumes, boundary_support, ...
    support_region] =  create_bkdual(bkgrid, pcoarse)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here

nodes = false(size(pcoarse.elemloc));
nodes(pcoarse.centers) = true;
[sub_edges] = create_dual_edges(bkgrid,pcoarse);
edges = any(sub_edges,2);
edges(nodes) = false;
[dual_semi_faces,dual_semi_face_coarse_vol_neighbours_edges] ...
    = create_semifaces(bkgrid,pcoarse);
%% checking integrity of semifaces
for ii = 1:size(dual_semi_faces,2)
    dual_semi_faces(:,ii) = integrity_face(dual_semi_faces(:,ii)); 
end

[sub_faces] = create_dual_faces(bkgrid,dual_semi_faces, ...
                        dual_semi_face_coarse_vol_neighbours_edges);

faces = any(dual_semi_faces,2);
faces(edges) = false;
faces(nodes) = false;
internals = ~(nodes|edges|faces);
% boundary_support = create_boundary_support_region(bkgrid, ...
%                     dual_semi_face_coarse_vol_neighbours_edges, ...
%                     dual_semi_faces);
boundary_support = create_boundary_support_region_speed(bkgrid, sub_faces);

sub_volumes = 0;
end



