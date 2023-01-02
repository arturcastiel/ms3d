%dot(-TJK,LJ) = -dTJK
%dot(-TJI,LJ) = -dTJI

syms A hL TJK KnL KTJKL  KTJIL pI pJ pK dTJK dTJI
expression = -(((1/(2*hL*A))*((-dTJK*KnL+hL*A*KTJKL)*...
     (pI-pJ)-2*(A^2)*KnL*pJ+(-dTJI*KnL+hL*A*KTJIL)*(pJ-pK))));
expression  = expand(expression);
expression = collect(expression,[pI pJ pK])