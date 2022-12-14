% 
% postprocessor3D(dcoarse.nodes, 'dual-nodes', 1 );
% postprocessor3D(dcoarse.edges, 'dual-edges', 1 );
% postprocessor3D(dcoarse.faces, 'dual-faces', 1 );
% postprocessor3D(dcoarse.internals, 'dual-internals', 1 );
dmesh = zeros(size(dcoarse.nodes));
dmesh(dcoarse.nodes) = 1;
dmesh(dcoarse.edges) = 2;
dmesh(dcoarse.faces) = 3;
dmesh(dcoarse.internals) = 4;
postprocessor3D(dmesh, 'dual_coarse_mesh', 1 );
