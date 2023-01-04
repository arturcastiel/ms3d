function [mesh,msmesh] = build_simulation_meshes(preconfig,msconfig)
%preprocessor Preprocessor creates the data structures of the untructured
%grid and the intialization parameter contained in the preconfig struct.
% create initialization files from here
[flagstruct] = create_flags_and_bc_structure();
[mesh.vertex, mesh.face, mesh.element, mesh.benchmark, mesh.wells, ...
    mesh.physical_properties] = preprocessor_tetrahedron_mesh(preconfig,...
                                                            flagstruct);
if preconfig.run_ms
    [msmesh.bkgrid, msmesh.pcoarse, msmesh.dcoarse] = ...
        create_msentities(msconfig, mesh);
else
    msmesh = 0;
end
end