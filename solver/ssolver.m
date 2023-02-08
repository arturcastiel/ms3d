function [x,flyp2,rvyp2] = ssolver(A,b,varargin)
if isempty(varargin)
    xg = ones(size(b));
else
    xg = varargin{1};
end
tol = 1*10^-12;
maxit = 6000;
flyp2 = 0;
rvyp2 = 0;
ref = symrcm(A);
A = A(ref,ref);
b = b(ref);
% [P,R,C] = equilibrate(A);
% B = R*P*A*C;
% d = R*P*b;
[L2,U2] = ilu(A,struct('type','ilutp','droptol',5e-2,'thresh',0));
 %[x,flyp2,~,~,rvyp2] = gmres(A,b,[],tol,maxit,L2,U2,xg);
x = bicgstab(A,b,tol,maxit,L2,U2,xg);
[~,refb] = sort(ref);
x = x(refb);
%x = bicgstab(A,b,tol,maxit,[],[],xg);
end