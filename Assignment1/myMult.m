function C = myMult(A,B)
   dimA =size(A);
   dimB =size(B);
   dimC= [dimA(1) dimB(2)];
   for i = 1:dimC(1)
       for j = 1:dimC(2)
           C(i,j) = 0;
           for k = 1:dimA(2)
               C(i,j)=C(i,j)+ (A(i,k)*B(k,j));
           end
       end
   end
end