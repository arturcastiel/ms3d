clear
clc
%% adding folder to the main path
path(path,'bkgrid3d');
path(path,'preprocessor');
path(path,'tools');
path(path,'debug');
%% defining the intialization parameters of the simulation
preconfig = create_preprocessor_config_structure();
msconfig = create_multiscale_config_structure();

%% creating the simulation

[vertex, element, face, wells] = build_simulation(preconfig, msconfig);
