A = [1 2 3; 3 4 5; 1 2 3];
[C,ia,ib]=unique(A,'rows','stable');
i=true(size(A,1),1);
i(ia)=false;
A(i,:)=0;