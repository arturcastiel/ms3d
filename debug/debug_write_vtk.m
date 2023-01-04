% vnames = ["pressure", "saturation", "artur"];
% folderpath = pwd;
% fname = "debug_vtk";
% write_vtk_tetrahedral_volumes(element.centroid(:,1:3),vnames,folderpath,...
%                             fname, vertex.coord, element.vertices);

vnames = ["velocity", "test", "calor"];
folderpath = pwd;
fname = "debug_vtk";
% write_vtk_tetrahedral_volumes_vectors([element.centroid(:,1:3) ...
%     element.centroid(:,1:3) ],vnames,folderpath,fname, vertex.coord, ...
%                                                     element.vertices,1);
prop = [vertex.coord];
write_vtk(prop, vnames, 0, 0, folderpath, fname, 1)


vnames = ["velocity", "test"];
folderpath = pwd;
fname = "debug_face_vtk";
prop = [face.bound.vertices(:,1:2); face.inner.vertices(:,1:2)];
write_vtk_tetrahedral_faces(prop,vnames,folderpath,fname, vertex.coord, ...
                             [face.bound.vertices; face.inner.vertices],1);

%% testing volumes

vnames = ["pressure"];
folderpath = pwd;
fname = "debug_face_vtk";
prop = [vertex.coord];
write_vtk_tetrahedral_nodes(prop,vnames,folderpath,fname, vertex.coord, ...
                             element.vertices);
