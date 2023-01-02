function create_diary(preconfig)
folder = fullfile(pwd,preconfig.output_folder);
if ~(isfolder(folder))
    mkdir(folder)
end
file_path = fullfile(folder, "log.txt");
diary(file_path);
end