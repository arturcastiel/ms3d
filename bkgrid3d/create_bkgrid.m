function [coord, elem, F, fElem, bfaces, element_center, face_center, ...
    face_neighbours, normals, edges_adj, face_edges, elem_edges, ...
    edge_centers] = create_bkgrid(msconfig,mesh)
% Function that create the structure with the elements of the background 
% grid. It uses the configuration parameter from the msconfig struct.
if msconfig.read_msh_file
    [elem,coord] = read_bkgrid(msconfig.bkgrid_mesh);
end

if msconfig.create_bkgrid
    coarse_vec = msconfig.coarsening;
    [elem,coord] = generate_base_bkcoarsegrid(coarse_vec(1), ...
        coarse_vec(2),coarse_vec(3), mesh);
    if msconfig.create_bkgrid_visualization
        create_bkgrid_msh_file(coord,elem, ...
            msconfig.create_bkgrid_visualization_name, ...
            msconfig.create_bkgrid_visualization_folder);
    end
end
[F, fElem, bfaces, face_neighbours] = create_bkfaces(elem);
element_center = findcentelem(coord, elem);
face_center = findcentelem(coord, F);
normals = compute_normals(F,coord);
[edges_adj, face_edges]= create_edges(F);
[elem_edges] = create_elem_edges(fElem, face_edges);
[edge_centers] = findcentelem(coord, edges_adj);
end

