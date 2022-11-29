
ii = 14;
postprocessor3D( boundary_support(:,ii), 'all_faces', 1 );
postprocessor3D( pcoarse.elemloc==ii, 'volumes', 1 );

