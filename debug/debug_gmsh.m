num_coord = size(coord,1);
gmsh_coord = [[1:num_coord]' coord];


num_elem = size(elem,1);
gmsh_elem = [[1:num_elem]' 5*ones(num_elem,1) 2*ones(num_elem,1) ... 
    ones(num_elem,1) ones(num_elem,1) elem];