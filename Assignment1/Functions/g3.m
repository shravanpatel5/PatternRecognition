function val = g3(x,cov,w1,w2)
    val = Mult(w1,x) +w2 -(0.5)*Mult(Mult(Trans(x),Inv(cov)),x)  ;
end