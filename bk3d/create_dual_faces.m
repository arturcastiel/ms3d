function [sub_faces] = create_dual_faces(bkgrid,dual_semi_faces, ...
                        semi_faces_ref)
%UNTITLED24 Summary of this function goes here
%   Detailed explanation goes here
sub_faces = false(size(dual_semi_faces,1),size(bkgrid.edges,1));
for index_edge = 1:size(bkgrid.edges,1)
    ref = semi_faces_ref(:,end) == index_edge;
    sub_faces(:,index_edge) = any(dual_semi_faces(:,ref),2);
end
end