
ii = 25;
postprocessor3D( boundary_support(:,ii), 'support', 1 );
postprocessor3D( pcoarse.elemloc==ii, 'volumes', 1 );

