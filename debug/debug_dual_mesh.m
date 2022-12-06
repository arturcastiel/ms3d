
ref_faces = any(boundary_support,2);
ref_edges = any(edges,2);
location_vector = zeros(size(ref_edges));

location_vector(ref_faces) = 1;

location_vector(ref_edges) = 2;

location_vector(pcoarse.centers) = 3;


postprocessor3D( location_vector, 'dual_coarse_mesh', 1 );
postprocessor3D( pcoarse.elemloc, 'primal_coarse_mesh', 1 );

