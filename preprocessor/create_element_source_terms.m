function [element_source] = ...
                        create_element_source_terms(element, flagstruct)
element_source = sparse(size(element.centroid,1),1);
for index = 1:size(flagstruct.flag_value_source,1)
    bc = flagstruct.flag_value_source(index,1);
    val = flagstruct.flag_value_source(index,2); 
    ref = element.region == bc;
    vol = element.volume(ref);
    total_vol = sum(vol);
    weight = vol ./ total_vol;
    element_source(ref) = weight .* val;    
end
end