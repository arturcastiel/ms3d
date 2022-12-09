function [sub_volumes] = create_sub_volumes(bkgrid, pcoarse, sub_faces, ...
                                                        sub_edges)
%UNTITLED27 Summary of this function goes here
%   Detailed explanation goes here

sub_volumes = false(size(pcoarse.elemloc,1),size(bkgrid.coord,1));

for node = 1:size(bkgrid.coord,1)
    ref = any(bkgrid.edges == node,2);   
end
 
outputArg1 = inputArg1;
outputArg2 = inputArg2;
end