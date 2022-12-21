function [coarse_center] = define_pcenters(bkgrid, mesh, elemloc)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
npar = max(elemloc);
coarse_center = zeros(npar,1);
for ii = 1:npar
    ref = elemloc == ii;
    pcenter = bkgrid.element_center(ii,:);
    fine_centers = mesh.element.centroid(ref,:);
    dist = distp1pm(pcenter,fine_centers);
    ref_min = dist == min(dist);
    min_dist_el = find(ref_min);
    if any(size(min_dist_el) > 1)
        min_dist_el = min_dist_el(1);
    end
    ref_min(:) = false;
    ref_min(min_dist_el) = true;
    ref(ref==true) = ref_min;
    coarse_center(ii) = find(ref);

end
end