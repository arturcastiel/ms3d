function [reft] = inVol3d(centers, face_normals,...
                            face_centers, element_center)

%UNTITLED10 Summary of this function goes here
%   Detailed explanation goes here
reft = true(size(centers,1),1);
for ii = 1:size(face_normals,1)
    normal = face_normals(ii,:);
    fcenter = face_centers(ii,:);
    ref = semi_plane_check(centers, normal, fcenter,element_center);
    %[ii sum(reft)]
    reft = reft & ref;
end

end