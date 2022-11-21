function [center]  = findcentelem(tcoord, telem)
    % recieves coord matrix and element matrix and calculate the center
    % of the element
    el_type = sum(telem ~=0,2);
    num_node = unique(el_type);
    center = zeros(size(telem,1),3);
    for ii = num_node'
        local_flag = el_type == ii;
        for el = 1:(ii)
            center(local_flag,:) = center(local_flag,:) + tcoord(telem(local_flag,el),:);
        end
        center(local_flag,:) = center(local_flag,:)/ii;
    end
    
end
