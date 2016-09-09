function cov = myCov(data , mean)
    len=length(data);
    cov = zeros(2,2);
    for i = 1:len
        cov(1,1)=cov(1,1)+ ((data(i,1)-mean(1))^2);
    end
    for i = 1:len
        cov(2,2)=cov(2,2)+ ((data(i,2)-mean(2))^2);
    end
    for i = 1:len
        cov(1,2)=cov(1,2)+ ((data(i,1)-mean(1))*(data(i,2)-mean(2)));
    end
    cov(2,1)=cov(1,2);
    cov = cov/len;
end