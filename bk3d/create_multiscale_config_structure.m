function msconfig = create_multiscale_config_structure()
% STRUCT FOR THE CONFIG OF THE MULTISCALE METHODS
msconfig = struct;
msconfig.run_ms = true;
msconfig.bkgrid_mesh = "cube_hex3x3.msh";
msconfig.read_msh_file = true;
msconfig.create_bkgrid = true;
msconfig.coarsening = [3 3 3];
end% 
% bkgrid_ = "cube03.msh";
%     coarse_example = "cube_hex.msh";
%     coarse_example = "cube_hex3x3.msh";
