% dual_representation = zeros(size(element.centroid,1),1);
% 
% ref = find(any(bkgrid.face_neighbours == 14,2));
% dual_representation(any(dcoarse.sub_edges(:,ref),2)) = 1;
% dual_representation(pcoarse.elemloc == 14) = 2;


% dual_representation = zeros(size(element.centroid,1),1);
% 
% ref = bkgrid.elem_edges(14,:);
% dual_representation(any(dcoarse.sub_faces(:,ref),2)) = 1;
% %dual_representation(pcoarse.elemloc == 14) = 2;
% 
% dual_representation = zeros(size(element.centroid,1),1);
% elem_nodes = bkgrid.elem(14,:);
% index = 1;
% for el = elem_nodes
%     dual_representation(dcoarse.sub_volumes(:,el)) = index;
%     index = index + 1;
% end
% %dual_representation(any(dcoarse.sub_volumes(:,elem_nodes),2)) = 1;
% postprocessor3D(dual_representation, 'teste', 1 );
dual_representation = zeros(size(element.centroid,1),1);

dual_representation(dcoarse.support_region(:,14)) = 2;
dual_representation(dcoarse.boundary_support(:,14)) = 1;
postprocessor3D(dual_representation, 'teste', 1 );
