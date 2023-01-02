function [preconfig] = create_preprocessor_config_structure()
% STRUCT FOR THE CONFIG OF THE MULTISCALE METHODS
preconfig = struct;
%% Discretization Type
% 1 - TPFA
% 2 - MPFA-D
preconfig.pressure_discretization = 2;
%% Interpolation Type
% 1 - Inverse Distance
% 2 - Variation of Inverse Distance
preconfig.interpolaton_type = 1;
preconfig.read_wells = true;
preconfig.mesh_file = "benchtetra_8.msh";
preconfig.mesh_folder = "Malhas";
preconfig.run_fracture_simulation = "true";
preconfig.fracture_network_file = "fracture.txt";
preconfig.fracture_network_folder = "Malhas";
preconfig.run_flux_limitation_procedure = "true";
preconfig.run_ms = true;
preconfig.output_folder = "test_folder";

% preconfig.permeablity_list = [1 0 0 0 1 0 0 0 1; ...
%                               1 0 0 0 1 0 0 0 1; ...
%                               1 0 0 0 1 0 0 0 1; ...
%                               1 0 0 0 1 0 0 0 1; ...
%                               1 0 0 0 1 0 0 0 1];
end
