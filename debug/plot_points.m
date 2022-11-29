function plot_points(auxmat)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
cx = auxmat(:,1);
cy = auxmat(:,2);
cz = auxmat(:,3);
scatter3(cx,cy,cz);
end