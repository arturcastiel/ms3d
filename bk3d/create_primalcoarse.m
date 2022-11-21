function [outputArg1,outputArg2] = create_primalcoarse(bkgrid)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
global vertex element face
1
[cloc] = primal_candidate(bkgrid)
n1 = normals(1,:);
fc1 = bkgrid.face_center(1,:);

el_center = [0.5 0.5 0.5]
semi_plane_check(bkgrid.coord, n1, fc1, el_center)
%
outputArg1 = inputArg1;
outputArg2 = inputArg2;
end


function [cloc] = primal_candidate(bkgrid)
    global element
    nel = size(bkgrid.elem,1);
    cloc = zeros(size(element.vertices,1),1);
    normals = compute_normals(bkgrid.faces(:,1:3),bkgrid.coord);

    for ii = 1:nel
            faces = bkgrid.elem_faces(ii,:);
            faces = faces(faces ~=0);
            faces_normals = normals(faces',:);
            inVol3d(element.centroid, faces_normals,bkgrid.face_center(faces,:), bkgrid.element_center(ii,:))


    end
end