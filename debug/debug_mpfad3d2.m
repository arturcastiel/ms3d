disp("Entering debug mpfad -3d script")
tol = 10^-14;
mtpfa = summation*face_trans_tpfa;
mcdt = summation*face_trans_cdt;
M = mcdt + mtpfa;
Bcdt = summation*(face_source_cdt);
Btpfa = summation*(face_source_tpfa);
%B = Bcdt + Btpfa;
load tulio
mcdt2 = tulio.Mcdt;
mtpfa2 = tulio.Mtpfa;
Btpfa2 = tulio.Btpfa;
Bcdt2 = tulio.Btpfa;


%p1 = M\B;
Bcdt = summation*(face_source_cdt);
Btpfa = summation*(face_source_tpfa);
aB = Bcdt + Btpfa;
analyze = full([Btpfa Btpfa2 abs(Btpfa - Btpfa2)]);
analyze2 = full([Bcdt Bcdt2 abs(Bcdt - Bcdt2)]);
% 
% M(:) = 0;
% mesh
% a = 0;
% for ii = 1:size(mesh.vertex.coord,1)
%     w = mesh.pressure_solver_param.vertex.weights;
%     w = w(ii,:);
%     [ M, B ] = contribuvertex3D2(mesh, M, B, mesh.pressure_solver_param.inner.t_eq, ...
%         mesh.pressure_solver_param.inner.gv, w, a, ii );
% end
1
if all(all(abs((mtpfa - mtpfa2)) < tol))
    disp("Mtpfa successfully created.")
else
    disp("Error on the creation of Mtpfa.")
end

if all(all(abs((mcdt - mcdt2)) < tol))
    disp("Mcdt successfully created.")
else
    disp("Error on the creation of Mcdt.")
end


if all(abs(analyze(:,end)) < tol)
    disp("Btpfa successfully created.")
else
    disp("Error on the creation of Btpfa.")
end
if all(abs(analyze2(:,end)) < tol)
    disp("Bcdt successfully created.")
else
    disp("Error on the creation of Bcdt.")
end
qq = full([sum(mcdt2,2) sum(mcdt,2)]);
error_el = abs(qq(:,1) - qq(:,2));
write_vtk(error_el,"error", 3, false, pwd, "git_error", mesh,1)

p1 = (mcdt2+mtpfa2)\B ;
p2 = (mcdt+mtpfa)\aB ;

write_vtk([p1 p2],["pressure-tulio" "pressure-artur"], 3, false, pwd, "git_pressure", mesh,1)
1