function write_props_hf5(props, prop_names, fpath)
fileName = fullfile(fpath,'props.h5');
if isfile(fileName)
    delete(fileName)
end
for index = 1:size(props,2)
    local_prop_name = "/" + prop_names(index);
    h5create(fileName , local_prop_name, size(props(:,index),1));
    h5write(fileName, local_prop_name, props(:,index));
end
end