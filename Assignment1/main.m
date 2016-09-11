prompt='\nDatasets : \n1)LinearlySeparableData \n2)NonLinearlySeparableData-Interlock \n3)NonLinearlySeparableData-Ring \n4)NonLinearlySeparableData-Spiral \n5)OverlappingData \n6)RealData \nEnter dataset number : ';
dataset= input(prompt);
prompt='\nClassifiers : \n1)Bayes-SameCovarianceMatrix(i) \n2)Bayes-SameCovarianceMatrix(ii) \n3)Bayes-DifferentCovarianceMatrix \n4)NaiveBayes-SigmalCovarianceMatrix \n5)NaiveBayes-SameCovarianceMatrix \n6)NaiveBayes-DifferentCovarianceMatrix \nEnter classifier number : ';
classifier= input(prompt);
    if(dataset==1)
        folder='LS_Group9';
        title='LinearlySeparableData-';
    elseif(dataset==2)
        folder='Interlock';
        title='NonLinearlySeparableData-Interlock';
    elseif(dataset==3)
        folder='Ring';
        title='NonLinearlySeparableData-Ring';
    elseif(dataset==4)
        folder='Spiral';
        title='NonLinearlySeparableData-Spiral';
    elseif(dataset==5)
        folder='OD_Group9';
        title='OverlappingData';
    elseif(dataset==6)
        folder='rd_group9';
        title='RealData';
    end  
    if(classifier==1)
        title=strcat(title,'-Bayes-SameCovarianceMatrix(i)');
    elseif(classifier==2)
        title=strcat(title,'-Bayes-SameCovarianceMatrix(ii)');
    elseif(classifier==3)
        title=strcat(title,'-Bayes-DifferentCovarianceMatrix');
    elseif(classifier==4)
        title=strcat(title,'-NaiveBayes-SigmalCovarianceMatrix');
    elseif(classifier==5)
        title=strcat(title,'-NaiveBayes-SameCovarianceMatrix');
    elseif(classifier==6)
        title=strcat(title,'-NaiveBayes-DifferentCovarianceMatrix');
    end  
if(dataset<5 && dataset~=1)
    numofclasses=2;
else
    numofclasses=3;
end
plotter(folder,numofclasses,classifier,title);