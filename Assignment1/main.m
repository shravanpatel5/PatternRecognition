function main(folder,numofclasses)
    file=strcat(folder,'/Class1.txt');
    D1=importdata(file);
    file=strcat(folder,'/Class2.txt');
    D2=importdata(file);
    if(numofclasses==3)
        file=strcat(folder,'/Class3.txt');
        D3=importdata(file);
    end
    myMean(D1)  
    myMean(D2)  
    myMean(D3)  
end    