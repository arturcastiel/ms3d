function [bcstruct] = create_flags_and_bc_structure()
bcstruct.run_benchmark_case = true;
bcstruct.benchmark_case = 1;
%% raise error if dirichlet and dirichlet share same flags
bcstruct.flag_value_dirichlet = [101 0;...
                                 102 1];
bcstruct.flag_value_neuman = [ 201 0;
                               202 1];
bcstruct.flag_value_source = [ 1 0];
bcstruct.permeablity_list = [1 0 0 0 1 0 0 0 1];
end
