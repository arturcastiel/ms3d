function [sub_faces] = create_dual_faces(bkgrid, pcoarse)
%create_dual_faces Function that creates the sub_faces of the dual coarse
%grid

%% refactory function to remove the need of the semi_faces_ref
[dual_semi_faces, semi_faces_ref] = create_semifaces(bkgrid,pcoarse);
%%
sub_faces = false(size(dual_semi_faces,1),size(bkgrid.edges,1));
for index_edge = 1:size(bkgrid.edges,1)
    ref = semi_faces_ref(:,end) == index_edge;
    sub_faces(:,index_edge) = any(dual_semi_faces(:,ref),2);
end
end