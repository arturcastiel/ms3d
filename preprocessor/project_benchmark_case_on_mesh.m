function [region, k_mapped] = ...
    project_benchmark_case_on_mesh(coord, k_fun, region)
    new_region = zeros(size(region));
    el_region = unique(region);
    acum = 0;
    index = 1;
    k_mapped = [];
    for el = el_region'
        local_k_fun = k_fun{el};
        ref = region == el;
        auxmat = local_k_fun(coord(ref,1), coord(ref,2), coord(ref,3));
        n = size(auxmat,1);
        acum = acum + index;
        if n == 1
            new_region(ref) = acum;
            k_mapped = [k_mapped; auxmat];
            index = index + 1 ;
        else
            new_region(ref) = [acum:(acum+sum(ref)-1)]';
            k_mapped = [k_mapped; auxmat];
            index = index + sum(ref);    
        end
    end        
end