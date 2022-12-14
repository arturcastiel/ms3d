A = [1 0 0 0; ...
     0 1 0 1; ...
     1 1 1 0; ...
     0 0 1 0; ...
     1 1 1 0];

A = sparse(A);

B = [1 10 50 60 90]';
C = [1:5];

n_el = sum(A,2)

for index = 1:n_el

    N = A(index,:);

end