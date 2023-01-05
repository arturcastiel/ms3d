disp("Debug Module: Entering flow channel flags adaptation")
 ref = mesh.vertex.flag == 101;
 ref_101 = ref;
 ref_102 = ref;
 ref_201 = ref;
 semi_coord = mesh.vertex.coord(ref,:);
 ref_101(ref_101) = semi_coord(:,1) == 0;
 ref_102(ref_102) = semi_coord(:,1) == 1;
 ref_201 = ~(ref_101 | ref_102) & ref;
 mesh.vertex.flag(ref_101) = 101;
 mesh.vertex.flag(ref_102) = 102;
 mesh.vertex.flag(ref_201) = 201;
%% debug tulio linear
%nodes = unique(mesh.face.bound.vertices);
%f = @(x,y,z) x;
%p = mesh.vertex.coord(nodes,1);
