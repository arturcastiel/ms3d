function [bcstruct] = create_flags_and_bc_structure()
% STRUCT FOR THE CONFIG OF THE MULTISCALE METHODS
bcstruct.run_benchmark_case = true;
bcstruct.benchmark_case = 5;
%% raise error if dirichlet and dirichlet share same flags
bcstruct.flag_value_dirichlet = [101 14;...
                                102 1;...
                                103 0.5];
bcstruct.flag_value_neuman = [ 201 0;
                               202 1];
bcstruct.permeablity_list = [1 0 0 0 1 0 0 0 1; ...
                              1 0 0 0 1 0 0 0 1; ...
                              1 0 0 0 1 0 0 0 1; ...
                              1 0 0 0 1 0 0 0 1; ...
                              1 0 0 0 1 0 0 0 1];
end
