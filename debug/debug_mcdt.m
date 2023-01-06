
ii = 53;
weight = mesh.pressure_solver_param.vertex.weights(ii,:)';
neigh = find(weight)';
local_weights = full(weight(weight~=0))';