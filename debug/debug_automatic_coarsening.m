ii = 5;
lenx = 1;
leny = 1;
lenz = 1;
X = [0:lenx/ii:lenx]';
Y = [0:leny/ii:leny]';
Z = [0:leny/ii:lenz]';

mX = size(X,1);
mY = size(Y,1);
mZ = size(Z,1);

ii = [1:mX]';
jj = [1:mY]';
kk = [1:mZ]';


[Xg, Yg, Zg] = meshgrid(X,Y,Z);
XX = reshape(Xg,[],1);
YY = reshape(Yg,[],1);
ZZ = reshape(Zg,[],1);

[IIg, JJg, KKg] = meshgrid(ii,jj,kk);
II = reshape(IIg,[],1);
JJ = reshape(JJg,[],1);
KK = reshape(KKg,[],1);

coord = [XX,YY, ZZ];
ind = [JJ II KK];
    counter = 1;
    elem = zeros((mX-1)*(mY-1)*(mZ-1), 8);
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
                    refin = sub2ind(size(Xg),auxmat(1),auxmat(2),auxmat(3));
                    lelem(1,index) = refin;
                end
                elem(counter,1:8) = lelem;   
                counter = counter +  1;
        end
    end
end
1

% Xt = pagetranspose(Xg);
% Yt = pagetranspose(Yg);
% Zt = pagetranspose(Zg);
% [Xn,Yn,Zn] = ndgrid(X',Y',Z');
% isequal(Xt,Xn) & isequal(Yt,Yn) & isequal(Zt,Zn)