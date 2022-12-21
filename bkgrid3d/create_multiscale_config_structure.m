function msconfig = create_multiscale_config_structure()
% STRUCT FOR THE CONFIG OF THE MULTISCALE METHODS
msconfig = struct;
msconfig.bkgrid_mesh = "cube_hex3x3.msh";
msconfig.read_msh_file = true;
msconfig.create_bkgrid = true;
msconfig.create_bkgrid_visualization = false;
msconfig.create_bkgrid_visualization_name = "bkgrid";
msconfig.create_bkgrid_visualization_folder = "Results";
msconfig.coarsening = [3 3 3];
msconfig.sparse_structures = false;
end