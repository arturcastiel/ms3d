function [elemloc] = ensure_cover(elemloc, mesh)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
npar = max(elemloc);
inedge = [mesh.face.inner.upstream mesh.face.inner.downstream];
while sum(elemloc == 0) ~= 0
    for ii = 1:npar
        ref1 = (elemloc(inedge(:,1)) == ii) & (elemloc(inedge(:,2)) == 0);
        ref2 = (elemloc(inedge(:,2)) == ii) & (elemloc(inedge(:,1)) == 0);
        ref = ref1 | ref2;
        if sum(ref) ~= 0
            elemloc(unique(inedge(ref,1:2))) = ii;
        end
    end
    
end
end

