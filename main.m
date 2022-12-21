clear
clc
%% adding folder to the main path
path(path,'tools')
required_folders = ["bkgrid3d", "pseudo_vectorization_tools", ...
    "preprocessor","debug", "mpfa3d", "postprocessing", "solver"];
for folder = required_folders
    add_folder_and_sub_folder_to_path(folder)
end
% path(path,'bkgrid3d');
% path(path,'pseudo_vectorization_tools');
% path(path,'preprocessor');
% path(path,'tools');
% path(path,'debug');
% add_folder_and_sub_folder_to_path("mpfa3d")
%% options is a struct used for compatibilization purpose. to be removed.
global options
[ options.caso, options.malha, options.tipopeso, options.calcpeso, ...
  options.limitadora, options.fractarch, options.flagcorresp ] = readopt3D;
%% defining the intialization parameters of the simulation
flagstruct = create_flags_and_bc_structure();
preconfig = create_preprocessor_config_structure();
msconfig = create_multiscale_config_structure();
%% compatibilization of preconfig and option structured, to be removed

%% creating the simulation
[mesh, msmesh] = build_simulation(preconfig, msconfig);
%% r
run_simulation(mesh, msmesh, flagstruct)
%% 


