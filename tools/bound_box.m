function [out] = bound_box(coord, bounding_nodes, tol)
%bound_box Check if the coords are contained in the bounding box formed by
%the bounding notes
auxvec = max(bounding_nodes);
max_x = auxvec(1);
max_y = auxvec(2);
max_z = auxvec(3);
auxvec = min(bounding_nodes);
min_x = auxvec(1);
min_y = auxvec(2);
min_z = auxvec(3);
ref1 = (coord(:,1) - tol <= max_x) & (coord(:,1) + tol>= min_x);
ref2 = (coord(:,2) - tol <= max_y) & (coord(:,2) + tol>= min_y);
ref3 = (coord(:,3) - tol <= max_z) & (coord(:,3) + tol >= min_z);
out = ref1&ref2&ref3;
end


