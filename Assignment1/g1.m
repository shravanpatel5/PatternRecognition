function val = g1(x,mean,var,prob_c)
    val = (myMult(myTrans(mean),x)/var) - (myMult(myTrans(mean),mean)/(2*var)) + log(prob_c);
end