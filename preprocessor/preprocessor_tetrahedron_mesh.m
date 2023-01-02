function [vertex,face, element, benchmark, wells, flagstruct] = ...
                    preprocessor_tetrahedron_mesh(preconfig, flagstruct)
%preprocessor_rock_matrix function that preprocess the discretization of
%the rock matrix according to the preconfig settings file
file_path = fullfile(pwd,preconfig.mesh_folder,preconfig.mesh_file);
% assembly basis of the mesh structured
vertex = struct;
element = struct;
face = struct;
benchmark = struct;
%% creating vertex and elements
[vertex.coord,nnode] = getcoord(file_path);
[element.vertices,element.region,boundary_flag_ref,vertex.flag ] = ...
                                            getelem(file_path, nnode);
[vertex.elsurvertex, vertex.elsurvertpointer, vertex.node_elem_adj] = ...
    find_elements_around_nodes(element.vertices);
[element.volume] =  volume_tetrahedron(vertex.coord,element.vertices);
[element.centroid] = findcentelem(vertex.coord,element.vertices);
if flagstruct.run_benchmark_case 
   [benchmark.analy_sol_fun, benchmark.perm_fun] = ...
                        create_benchmark_permeability_tensors(flagstruct);
   [element.region, flagstruct.permeablity_list] = ...
            project_benchmark_case_on_mesh(element.centroid, ...
            benchmark.perm_fun, element.region);
end
if preconfig.read_wells
    [wells_input] = create_input_wells();
    [wells.flux, wells.pressure] = process_wells(vertex, element, ...
                                                            wells_input);
else
    wells = 0;
end

%% creating faces and the element face adjacencies
[face.inner.vertices,face.bound.vertices, face.bound.flag, ...
 face.inner.upstream, face.inner.downstream, face.bound.upstream, ...
 face.bound.area, face.inner.area, face.bound.normal, ...
 face.inner.normal, face.bound.centroid, face.inner.centroid] = ...
                       create_faces(element.vertices,vertex.coord, ...
                                    element.centroid,boundary_flag_ref);

%% creating element faces adjacencies
[element.faces, element.faces_bol ] = create_elem_face_adj( ...
        face.inner.upstream, face.inner.downstream, face.bound.upstream);
end