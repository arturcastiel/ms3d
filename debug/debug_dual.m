ii = 3;

dual_loc = zeros(size(pcoarse.elemloc));
v_ref = pcoarse.elemloc == ii;
dual_loc(v_ref) = 1;
an_faces = bkgrid.elem_faces(ii,:);
out_edges = any(sub_edges(:,an_faces),2);
dual_loc(out_edges) = 3;
dual_loc(pcoarse.centers(ii)) = 2;

v_ref = bkgrid.elem_edges(ii,:);
dual_loc(any(sub_faces(:,v_ref),2)) = 4;

dual_loc(boundary_support(:,ii)) = 5;
postprocessor3D(dual_loc, 'dual_loc', 1 );

