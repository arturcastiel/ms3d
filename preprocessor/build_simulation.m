function  [mesh, msmesh] = build_simulation(preconfig,msconfig)
%preprocessor Preprocessor creates the data structures of the untructured
%grid and the intialization parameter contained in the preconfig struct.
%global vertex element face % the use of global variables is to be removed
tic
[mesh.vertex, mesh.face, mesh.element] = preprocessor_tetrahedron_mesh(preconfig);
toc

%% changs the name of the faces upstream and downstream elements to 
% montelem and just element for the sake of testing. TO BE REMOVED!
%debug_mesh_processor
%%

if preconfig.run_ms
    [msmesh.bkgrid, msmesh.pcoarse, msmesh.dcoarse] = ...
                                        create_msentities(msconfig, mesh);
end
toc

%% wells and bc need to be add to mesh struct
wells = 0;
end