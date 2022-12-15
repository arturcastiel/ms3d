function [reft] = inVol3d(centers, face_normals,...
                            face_centers, element_center)
%inVol3d checks if a list of elements are contained in a 3d convex volume
%   equivalent of inpolygon but for 3d
reft = true(size(centers,1),1);
for ii = 1:size(face_normals,1)
    normal = face_normals(ii,:);
    fcenter = face_centers(ii,:);
    ref = semi_plane_check(centers, normal, fcenter,element_center);
    reft = reft & ref;
end

end