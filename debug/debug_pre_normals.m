fn = face.bound.normal;
nfn = face1.bound.normal;
% all(all((fn == nfn) | (fn == (-1*nfn))))
% 
fn = face.inner.normal;
nfn = face1.inner.normal;
% 
% tol = 10^-14;
% ref1 = all(abs(fn - nfn) < tol);
% ref2 = all(abs(fn + nfn) < tol);
% ref = all(ref1|ref2);
% 
% ref2 = ~any(~(fn == nfn),2);

ref = fn - nfn;
refn = ref == 0;

ref_normal = all(refn,2);

ref2 = ref_normal;
auxmat = [face.inner.montelem(ref2) face.inner.juselem(ref2) ...
                face1.inner.upstream(ref2) face1.inner.downstream(ref2)];


ref = all(face.bound.montelem == face1.bound.upstream);
face.bound.montelem == face1.bound.upstream;