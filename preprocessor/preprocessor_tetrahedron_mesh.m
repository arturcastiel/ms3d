function [vertex,face, element] = preprocessor_tetrahedron_mesh(preconfig)
%preprocessor_rock_matrix function that preprocess the discretization of
%the rock matrix according to the preconfig settings file

file_path = fullfile(pwd,preconfig.mesh_folder,preconfig.mesh_file);
% assembly basis of the mesh structured
vertex = struct;
element = struct;
face = struct;
%% creating vertex and elements
[vertex.coord,nnode] = getcoord(file_path);
[element.vertices,element.region,boundary_flag_ref,vertex.flag ] = ...
                                            getelem(file_path, nnode);
[vertex.elsurvertex, vertex.elsurvertpointer, vertex.node_elem_adj] = ...
    find_elements_around_nodes(element.vertices);
[element.volume] =  volume_tetrahedron(vertex.coord,element.vertices);
[element.centroid] = findcentelem(vertex.coord,element.vertices);
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