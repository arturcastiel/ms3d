function [elem,coord] = generate_base_bkcoarsegrid(divx,divy,divz)
% generate_base_bkcoarsegrid: Function creates an automatic structured 
%   bkgrid without the need of a mesh file.
% Detailed explanation goes here
global vertex
auxvec = max(vertex.coord) - min(vertex.coord);
lenx = auxvec(1);
leny = auxvec(2);
lenz = auxvec(3);
X = [0:lenx/divx:lenx]';
Y = [0:leny/divy:leny]';
Z = [0:leny/divz:lenz]';
mX = size(X,1);
mY = size(Y,1);
mZ = size(Z,1);
[Xg, Yg, Zg] = meshgrid(X,Y,Z);
XX = reshape(Xg,[],1);
YY = reshape(Yg,[],1);
ZZ = reshape(Zg,[],1);
coord = [XX,YY, ZZ];
n_elem = (mX-1)*(mY-1)*(mZ-1);
elem = zeros(n_elem,8);
counter = 1;
for ii = 1:(mX-1)
    for jj = 1:(mY-1)
        for kk = 1:(mZ-1)
                Node1 = [ii,jj,kk];
                Node2 = [ii,jj,kk+1];
                Node3 = [ii,jj+1,kk+1];
                Node4 = [ii,jj+1,kk];
                F1 = [Node1; Node2; Node3; Node4];
                Node5 = [ii+1,jj,kk];
                Node6 = [ii+1,jj,kk+1];
                Node7 = [ii+1,jj+1,kk+1];
                Node8 = [ii+1,jj+1,kk];
                F2 = [Node5; Node6; Node7; Node8];
                F = [F1;F2];
                lelem = zeros(1,8);
                for index = 1:size(F,1)
                    auxmat = F(index,:); 
                    refin = sub2ind(size(Xg) ,auxmat(2),auxmat(1),auxmat(3));
                    lelem(1,index) = refin;
                end
                elem(counter,1:8) = lelem;   
                counter = counter +  1;
        end
    end
end
end