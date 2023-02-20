coords  = mesh.vertex.coord;
elem = mesh.element.vertices;
proops = mesh.vertex.coord;
write_vtk_node_vectors ...
                  (coords,"teste",pwd,"test.vtk", coords, elem)