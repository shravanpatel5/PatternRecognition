function val = g3(x,cov,w1,w2)
    val = ((0.5)*myMult(myMult(myTrans(x),myInv(cov)),x)) + myMult(w1,x) +w2 ;
end