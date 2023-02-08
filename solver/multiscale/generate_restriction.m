function [ OR ] = generate_restriction(msmesh)
%genProlongationOperator Generates Restriction Operator
%   INPUT:
%   msmesh -> multiscale mesh structure
%   OUTPUT:
%   OR = Restriction operator
    npar = max(msmesh.pcoarse.elemloc);
    nelem =  size(msmesh.pcoarse.elemloc,1);
    OR = false([npar , nelem]);
    for ii = 1:npar
        OR(ii,:) = msmesh.pcoarse.elemloc == ii;
    end
    OR = sparse(OR);
end