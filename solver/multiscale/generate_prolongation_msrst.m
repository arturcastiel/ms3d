function [ OP] = generate_prolongation_msrst(mesh, msmesh, OP_init, TransFc, w, maxint )
%genProlongationOperator Generates Prolongation Operator
%   INPUT:
%   mesh -> mesh structure
%   msmesh -> multiscale mesh structure
%   OP_init -> Initial Solution for OP
%   TransF -> Transmissibility Matrix without Dirichlet BC
%   w - relaxation parameter of JACOB approximation, usually set as 2/3
%   maxint - max number of iterations

%   OUTPUT:
%   OP = prolongation operator

    %TransFc = full(TransFc);
    GlobalBoundary = msmesh.dcoarse.faces | msmesh.dcoarse.edges;
    outSupport  = ~msmesh.dcoarse.support_region;
    %     rar = sum(msmesh.dcoarse.support_region,2) == 1;
%     rar(GlobalBoundary) = 
%     outSupport(,:) = true;
    %Dinv = sparse( diag(1./TransFc(1:size(TransFc,1)+1:end)));
    %Dinv = sparse( diag(bsxfun(@ldivide,spdiags(TransFc,0),1)) );
    Dinv =  spdiags(bsxfun(@ldivide,spdiags(TransFc,0),1),0,size(TransFc,1) ,size(TransFc,1) );
    
    %spdiags(TransFC,0)
    %OP = sparse(zeros(size(OPb)));
    OP = spalloc( size(OP_init,1), size(OP_init,2),nnz(OP_init)*2);
    
    intError = zeros(maxint,1);
    for index = 1: maxint
        %d = full( -w*((Dinv*(TransFc*OPb))))  ;
        d =  -w*((Dinv*(TransFc*OP_init )))  ;
        %d = full(d);
        maxD= max(d(~GlobalBoundary,:));       
        %d(outSupport) = 0;   
        d = d.*~outSupport;
        intError(index) = norm(maxD);
        d = sparse(d);
        OP = d + OP_init;
        %index
        %sum( OP(GlobalBoundary,:)
        OP(GlobalBoundary,:) = bsxfun(@rdivide, OP(GlobalBoundary,:) ,sum( OP(GlobalBoundary,:) ,2));
        %OP(GlobalBoundary,:) = OP(GlobalBoundary,:)./(sum(OP(GlobalBoundary,:),2)*(1?));
           % [index ant intError(index)]
        %OP(GlobalBoundary,:) = bsxfun(@rdivide, OP(GlobalBoundary,:) ,sum( OP(GlobalBoundary,:) ,2));
        %OP(GlobalBoundary,:) = bsxfun(@rdivide, OP(GlobalBoundary,:) ,sum( OP(GlobalBoundary,:) ,2));

         %use tol  0.00001
%          
         if index ~= 1
             if abs(intError(index)) < 0.0000001 ||  abs( intError(index) - intError(index-1)) < 0.0000001        %abs(intError(index) / intError(index-1)) > 1.02
                 %index
                 break
             end
         end
% 
% 
%          if abs(intError(index)) < 0.001
%              break
%          end
% %          if (( abs( intError(index+1) - intError(index))) < 0.00001 || (intError(index) < 0.0001)) && index ~= 0        	
%       
%              break
%          end

% % % 
%          if rem(index,1) == 0
%              postprocessorDebugS(full(OPb(:,11)),0,0,0,index,0,0,0,0,0);
%              index2 = index2+1;
%          end
%         

        
        OP_init = OP;
       
    end
    
%     if flag == 1
%       OP =  bsxfun(@minus,OP,min(OP));
%       OP =  bsxfun(@rdivide, OP,sum(OP,2));    
%     end
    
end