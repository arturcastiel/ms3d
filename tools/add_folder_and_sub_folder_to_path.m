function add_folder_and_sub_folder_to_path...
    (folder_name)
base_folder = fullfile(pwd,folder_name);
addpath(base_folder); 
addingfolders=dir(base_folder);
for folderid=3:size(addingfolders,1)
    local_path = fullfile(base_folder,addingfolders(folderid).name);
    if isfolder(local_path)
        addpath(local_path)
    end
  %addpath(fullfile(base_folder,addingfolders(folderid).name));
end
end