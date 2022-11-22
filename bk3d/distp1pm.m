function [dists] = distp1pm(pcenter,points)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
n = size(points,1);
pcenters = repelem(pcenter,n,1);
dists = vecnorm(pcenters-points,2,2);
end