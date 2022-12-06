pt = [0.1 0.2 0.0001];
p1 = [0 0 0];
p2 = [1 0 0 ];
p3 = [0 1 0];
p1 = repelem(p1,3,1);
p2 = repelem(p2,3,1);
p3 = repelem(p3,3,1);
pt = repelem(pt,3,1);
pm = (p1+p2+p3)./3;

check_point_in_triang(pm,p1,p2,p3)
check_point_in_triang(pt, p1,p2,p3)