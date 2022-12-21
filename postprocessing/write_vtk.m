function write_vtk(properties, prop_names, prop_type, isvec, folderpath,... 
                                                           fname, varargin)
global element face vertex
if ~isvec
    if prop_type == 0
        write_vtk_tetrahedral_nodes(properties, prop_names, ...
            folderpath,fname, vertex.coord, element.vertices, varargin{1});
    elseif prop_type == 2
        write_vtk_tetrahedral_faces(properties, prop_names, ...
            folderpath,fname, vertex.coord, [face.inner.vertices; ...
                                        face.bound.vertices], varargin{1});
    elseif prop_type == 3
        write_vtk_tetrahedral_volumes(properties, prop_names, ...
            folderpath,fname, vertex.coord, element.vertices, varargin{1});
    end
else
    if prop_type == 0
        write_vtk_tetrahedral_nodes_vectors(properties, prop_names, ...
            folderpath,fname, vertex.coord, element.vertices, varargin{1});
    elseif prop_type == 2
        write_vtk_tetrahedral_faces_vectos(properties, prop_names, ...
            folderpath,fname, vertex.coord, [face.inner.vertices; ...
                                        face.bound.vertices], varargin{1});
    elseif prop_type == 3
        write_vtk_tetrahedral_volumes_vectors(properties, prop_names, ...
            folderpath,fname, vertex.coord, element.vertices, varargin{1});
    end
end
end