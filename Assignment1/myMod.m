function val= myMod(A)
   if(size(A)==[2 2])
       val= (A(1,1)*A(2,2))-(A(1,2)*A(2,1));
   else
       val=0;
end
