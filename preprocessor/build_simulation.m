function  [vertex, face, element, wells, bkgrid, pcoarse, dcoarse] = ...
                                       build_simulation(preconfig,msconfig)
%preprocessor Preprocessor creates the data structures of the untructured
%grid and the intialization parameter contained in the preconfig struct.
tic
[vertex, face, element] = preprocessor_tetrahedron_mesh(preconfig);
toc
bkgrid = 0;
pcoarse = 0;
dcoarse = 0;
if msconfig.run_ms
    [bkgrid, pcoarse, dcoarse] = create_msentities(msconfig);
end
toc
wells = 0;
end