function [elemloc] = ensure_cover(elemloc)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
global vertex element face
npar = max(elemloc);
inedge = [face.inner.juselem face.inner.montelem];
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

