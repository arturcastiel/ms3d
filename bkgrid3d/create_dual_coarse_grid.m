function [nodes,edges,faces,internals,sub_edges,sub_faces,sub_volumes,...
    boundary_support, support_region] =  create_dual_coarse_grid(...
    bkgrid, pcoarse, mesh, msconfig)
%create_dual_coarse_grid creates the elements of the dual coarse mesh
[sub_edges] = create_sub_edges(bkgrid,pcoarse, mesh);
[sub_faces] = create_sub_faces(bkgrid,pcoarse, mesh);
[boundary_support] = create_boundary_support_region(bkgrid, mesh, ... 
                                                                sub_faces);
[sub_volumes] = create_sub_volumes(bkgrid, mesh, pcoarse);
[support_region] = create_support_region(bkgrid, mesh, sub_volumes, ...
    boundary_support);

nodes = false(size(pcoarse.elemloc));
nodes(pcoarse.centers) = true;
sub_edges(nodes,:) = false;
edges = any(sub_edges,2);
sub_faces(nodes,:) = false;
sub_faces(edges,:) = false;
faces = any(sub_faces,2);
internals = ~(nodes|edges|faces);
if msconfig.sparse_structures
    [sub_edges,sub_faces,sub_volumes,boundary_support,support_region] = ...
        convert_to_sparse(sub_edges,sub_faces,sub_volumes, ...
        boundary_support, support_region);
end
end
    


