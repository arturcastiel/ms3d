function [wells_flux, wells_pressure]  = process_wells(vertex, element,...
                                                               wells_input)
%UNTITLED14 Summary of this function goes here
%   Detailed explanation goes here
num_fwells = 1;
num_dwells = 1;
num_wells = size(wells_input,2);
for index = 1:num_wells
    if wells_input(index).btype == 2
        volume_percentage = zeros(size(element.centroid,1),1);
        nod_dist = check_if_inside_sphere(wells_input(index).nodes, vertex.coord);
        tetra_vert_dist = nod_dist(element.vertices) - ...
                                    wells_input(index).geometry_radius;
        ref_min_one_vert_insde =  any(tetra_vert_dist <= 0, 2);
        ref_all_vert_insde = all(tetra_vert_dist <=0,2);
        wells_ind = find(ref_min_one_vert_insde);
        ref_bound = ref_min_one_vert_insde;
        ref_bound(ref_all_vert_insde) = false;
        auxmat = tetra_vert_dist(ref_bound,:);
        amin = min(auxmat,[],2);
        amax = max(auxmat,[],2);
        arange = amax - amin;
        vol_est = mean(1 - auxmat./ arange,2);
        vol_est(vol_est > 1) = 1;
        vol_est = vol_est * 0.9;
        volume_percentage(ref_bound) = vol_est;
        volume_percentage(ref_all_vert_insde) = 1;
        auxvec = volume_percentage(ref_min_one_vert_insde).* ...
            element.volume(ref_min_one_vert_insde);
        sum_volumes = sum(auxvec);
        well_ind =  find(ref_all_vert_insde);
        well_flow = (auxvec./sum_volumes) .* wells_input(index).value;
        wells_flux(num_fwells).elements = well_ind;
        wells_flux(num_fwells).flux = well_flow;
        wells_flux(num_fwells).type = wells_input(index).type;
        num_fwells = num_fwells + 1;
    elseif wells_input(index).geometry_type == 1
        volum_dist = check_if_inside_sphere(wells_input(index).nodes, ...
            element.centroid);
        ref = volum_dist <= wells_input(index).geometry_radius;
        wells_pressure(num_dwells).type = wells_input(index).type;
        wells_pressure(num_dwells).elements = find(ref);
        wells_pressure(num_dwells).pressure = wells_input(index).value;
    end


end
end