function inv = myInv(A)
   inv(1,1)=A(2,2);
   inv(2,2)=A(1,1);
   inv(1,2)=A(1,2)*(-1);
   inv(2,1)=A(2,1)*(-1);
   inv = inv/myMod(A);
end