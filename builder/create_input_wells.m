function [wells] = create_input_wells()
%% CREATES AN ARRAY OF A WELL STRUCTS THAT DESRCRIBE THE WELLS
wells = struct();
%% creating injection well
% well types
% 1 - inject  2 - productiom
wells(1).type = 1;
% well boundary control type
% 1 - prescribed pressure 2 - prescribed flux
wells(1).btype = 2;
wells(1).value = 1;
% well geometry type
% 1 - node base 2- cylindrical
wells(1).geometry_type = 1;
wells(1).geometry_radius = 0.1;
wells(1).nodes = [0 0 0];
%% creating production well
%% creating injection well
% well types
% 1 - inject  2 - production
wells(2).type = 2;
% well boundary control type
% 1 - prescribed pressure 2 - prescribed flux
wells(2).btype = 1;
wells(2).value = 1;
% well geometry type
% 1 - node base 2- cylindrical
wells(2).geometry_type = 1;
wells(2).geometry_radius = 0.1;
wells(2).nodes = [0.5 0.5 0.5];

end