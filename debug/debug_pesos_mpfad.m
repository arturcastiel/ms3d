disp("Debug Module: Entering flow channel flags adaptation")
%  ref = mesh.vertex.flag == 101;
%  ref_101 = ref;
%  ref_102 = ref;
%  ref_201 = ref;
%  semi_coord = mesh.vertex.coord(ref,:);
%  ref_101(ref_101) = semi_coord(:,1) == 0;
%  ref_102(ref_102) = semi_coord(:,1) == 1;
%  ref_201 = ~(ref_101 | ref_102) & ref;
%  mesh.vertex.flag(ref_101) = 101;
%  mesh.vertex.flag(ref_102) = 102;
%  mesh.vertex.flag(ref_201) = 201;
ref1 = (mesh.vertex.coord(:,1) == 0) | (mesh.vertex.coord(:,1) == 1);
ref2 = (mesh.vertex.coord(:,2) ==    0) | (mesh.vertex.coord(:,2) == 1);
ref3 = (mesh.vertex.coord(:,3) == 0) | (mesh.vertex.coord(:,3) == 1);
ref = ref1 | ref2 | ref3;
mesh.vertex.flag(ref) = 101;
write_vtk(mesh.vertex.flag ,"flags", 0, false, pwd, "vtk_flag", mesh,1)
1
%% debug tulio linear
%nodes = unique(mesh.face.bound.vertices);
%f = @(x,y,z) x;
%p = mesh.vertex.coord(nodes,1);
