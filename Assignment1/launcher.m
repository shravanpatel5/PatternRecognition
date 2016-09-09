prompt='Enter dataset number : ';
dataset= input(prompt);
    if(dataset==1)
        folder='LS_Group9';
    elseif(dataset==2)
        folder='Interlock';
    elseif(dataset==3)
        folder='Ring';
    elseif(dataset==4)
        folder='Spiral';
    elseif(dataset==5)
        folder='OD_Group9';
    elseif(dataset==6)
        folder='rd_group9';
    end  
if(dataset<5 && dataset~=1)
    numofclasses=2;
else
    numofclasses=3;
end
main(folder,numofclasses);