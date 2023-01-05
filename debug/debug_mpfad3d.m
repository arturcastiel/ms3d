disp("Entering debug mpfad -3d script")
mtpfa = summation*face_trans_tpfa;
sum(mtpfa,2);
mcdt = summation*face_trans_cdt;
M = mcdt + mtpfa;
load B
load Btpfa
load Bcdt
load mcdt2 
load mtpfa2
m2 = mtpfa2 + mcdt2;
p1 = M\B;
aBcdt = summation*(face_source_cdt);
aBtpfa = summation*(face_source_tpfa);

analyze = full([Btpfa aBtpfa abs(Btpfa - aBtpfa)]);
analyze2 = full([Bcdt aBcdt abs(Bcdt - aBcdt)]);

1
p2 = M\aB ;


write_vtk([p1 p1],["pressure-tulio" "pressure-artur"], 3, false, pwd, "git_pressure", mesh,1)
1