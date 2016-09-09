function main(folder,numofclasses)
    file=strcat(folder,'/Class1.txt');
    A1=importdata(file);
    len=length(A1)*.75;
    D1 = A1(1:len,:);
    file=strcat(folder,'/Class2.txt');
    A2=importdata(file);
    len=length(A2)*.75;
    D2 = A2(1:len,:);
    if(numofclasses==3)
        file=strcat(folder,'/Class3.txt');
        A3=importdata(file);
        len=length(A3)*.75;
        D3 = A3(1:len,:);
    end
     %myCov(D1,myMean(D1))
     %cov(D1)
end    