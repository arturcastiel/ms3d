clear
clc
%% adding folder to the main path
path(path,'tools')
required_folders = ["builder","bkgrid3d", "pseudo_vectorization_tools", ...
    "preprocessor","debug", "mpfa3d", "postprocessing", "solver"];
for folder = required_folders
    add_folder_and_sub_folder_to_path(folder)
end
%% defining the intialization parameters of the simulation
preconfig = create_preprocessor_config_structure();
msconfig = create_multiscale_config_structure();
%% create diary - diary needs to log only disp to avoid logs becoming too
% diary needs configuration
%create_diary(preconfig);
%% creating the simulation
tic
[mesh, multiscale_mesh] = build_simulation(preconfig, msconfig);
%% simulation solver
run_simulation(mesh)
%% 


