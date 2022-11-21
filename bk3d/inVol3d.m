function [outputArg1,outputArg2] =inVol3d(centers, face_normals, face_centers, element_center)

%UNTITLED10 Summary of this function goes here
%   Detailed explanation goes here

for ii = 1:size(face_normals,1)
    normal = face_normals(ii,:);
    center = face_centers(ii,:);
    semi_plane_check()


end

outputArg1 = inputArg1;
outputArg2 = inpusZtArg2;
end