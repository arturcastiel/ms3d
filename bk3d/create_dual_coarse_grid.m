function [nodes,edges, faces, internals, sub_edges, sub_faces,sub_volumes, boundary_support, ...
    support_region] =  create_dual_coarse_grid(bkgrid, pcoarse)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
[sub_edges] = create_dual_edges(bkgrid,pcoarse);
[sub_faces] = create_sub_faces(bkgrid,pcoarse);
[boundary_support] = create_boundary_support_region_speed(bkgrid, sub_faces);
[support_region] = create_support_region(pcoarse, boundary_support);
[sub_volumes] = create_sub_volumes(bkgrid,pcoarse, sub_faces, sub_faces);

nodes = false(size(pcoarse.elemloc));
nodes(pcoarse.centers) = true;
edges = any(sub_edges,2);
edges(nodes) = false;
faces = any(sub_faces,2);
faces(edges) = false;
faces(nodes) = false;
internals = ~(nodes|edges|faces);


end



