function mean = myMean(data)
    mean = [0 0]  ;
    for i = 1:length(data)
        mean(1)= data(i,1);
        mean(2)= data(i,2);
    end 
    mean(1) = mean(1)/length(data);
    mean(2) = mean(2)/length(data);
end