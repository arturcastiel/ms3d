function [vertex, element, face, wells] = mesh_processor(preconfig)
%preprocessor Preprocessor creates the data structures of the untructured
%grid and the intialization parameter contained in the preconfig struct.
[vertex, face, element, wells] = preprocessor_rock_matrix(preconfig);

end