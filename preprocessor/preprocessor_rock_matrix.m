function [vertex,face, element, wells] = preprocessor_rock_matrix(preconfig)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
file_path = fullfile(pwd,preconfig.mesh_folder,preconfig.mesh_file);
% assembly basis of the mesh structured
vertex = struct;
element = struct;
face = struct;
[vertex.coord,nnode] = getcoord(file_path);
[element.vertices,element.region,boundary_flag_ref,vertex.flag ] = ...
                                            getelem(file_path, nnode);
[vertex.elsurvertex, vertex.elsurvertpointer, vertex.node_elem_adj] = ...
    find_elements_around_nodes(element.vertices);
[element.volume] =  volume_tetrahedron(vertex.coord,element.vertices);
[element.centroid] = findcentelem(vertex.coord,element.vertices);
[face.inner.vertices,face.bound.vertices, face.bound.flag, ...
 face.inner.upstream, face.inner.downstream, face.bound.upstream, ...
 face.bound.area, face.inner.area, face.bound.normal, ...
 face.inner.normal, face.bound.centroid, face.inner.centroid, ...
 element.faces] = create_faces(element.vertices,vertex.coord,....
                    element.centroid,boundary_flag_ref);
wells = 0;
end