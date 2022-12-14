function  [vertex, element, face, wells, bkgrid, pcoarse, dcoarse] = ...
                                       build_simulation(preconfig,msconfig)
%preprocessor Preprocessor creates the data structures of the untructured
%grid and the intialization parameter contained in the preconfig struct.
global vertex element face % the use of global variables is to be removed
tic
[vertex, face, element] = preprocessor_tetrahedron_mesh(preconfig);
%% changs the name of the faces upstream and downstream elements to 
% montelem and just element for the sake of testing. TO BE REMOVED!
debug_mesh_processor
%%
toc
bkgrid = 0;
pcoarse = 0;
dcoarse = 0;
if msconfig.run_ms
    [bkgrid, pcoarse, dcoarse] = create_msentities(msconfig);
end
wells = 0;
end