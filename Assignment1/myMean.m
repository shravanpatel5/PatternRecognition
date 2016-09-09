function mean= myMean(data)
sum_d = [0;0]  ;
for i = 1:length(data)
    sum_d(1)= data(i,1);
    sum_d(2)= data(i,2);
end 
sum_d(1) = sum_d(1)/length(data);
sum_d(2) = sum_d(2)/length(data);
end
a = [ 1 2 ; 3 4 ; 5 6 ; 7 8 ; 9 10 ] ;
myMean(a) 