

postprocessor3D(nodes, 'dual-nodes', 1 );
postprocessor3D(edges, 'dual-edges', 1 );
postprocessor3D(faces, 'dual-faces', 1 );
postprocessor3D(internals, 'dual-internals', 1 );
dmesh = zeros(size(nodes));
dmesh(nodes) = 1;
dmesh(edges) = 2;
dmesh(faces) = 3;
dmesh(internals) = 4;
postprocessor3D(internals, 'dual_coarse_mesh', 1 );
