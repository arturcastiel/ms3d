function [preconfig] = create_preprocessor_config_structure()
% STRUCT FOR THE CONFIG OF THE MULTISCALE METHODS
preconfig = struct;
preconfig.interpolaton_type = 1;
preconfig.benchmark_case = 20;
preconfig.mesh_file = "benchtetra_5.msh";
preconfig.mesh_folder = "Malhas";
preconfig.run_fracture_simulation = "true";
preconfig.fracture_network_file = "fracture.txt";
preconfig.fracture_network_folder = "Malhas";
preconfig.run_flux_limitation_procedure = "true";
end
