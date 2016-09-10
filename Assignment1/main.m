function main(folder,numofclasses,classifier)
    file=strcat(folder,'/Class1.txt');
    A1=importdata(file);
    len=length(A1);
    len1=floor(len*.75);
    D1 = A1(1:len1,:);
    T1 = A1(len1+1:len,:);
    file=strcat(folder,'/Class2.txt');
    A2=importdata(file);
    len=length(A2);
    len2=floor(len*.75);
    D2 = A2(1:len2,:);
    T2 = A2(len2+1:len,:);
    if(numofclasses==3)
        file=strcat(folder,'/Class3.txt');
        A3=importdata(file);
        len=length(A3);
        len3=floor(len*.75);
        D3 = A3(1:len3,:);
        T3 = A3(len3+1:len,:);
    end
    if(numofclasses==2)
        len=len1+len2;
        probc1=len1/len;
        probc2=len2/len;
        mean1 = myMean(D1);
        mean2 = myMean(D2);
        cov1 = myCov(D1,mean1);
        cov2 = myCov(D2,mean2);
        confusion=zeros(2,2);
        if(classifier==1)
            cov = (cov1+cov2)/2;
            w11 = myTrans(myMult(myInv(cov),mean1));
            w12 = - (0.5*myMult(myMult(myTrans(mean1),myInv(cov)),mean1)) + log(probc1);
            w21 = myTrans(myMult(myInv(cov),mean2));
            w22 = - (0.5*myMult(myMult(myTrans(mean2),myInv(cov)),mean2)) + log(probc2);
            for i = 1:length(T1)
                x = myTrans(T1(i,:)); 
                x1=g2(x,w11,w12);
                x2=g2(x,w21,w22);
                if(x1>x2)
                    confusion(1,1)=confusion(1,1)+1;
                else
                    confusion(1,2)=confusion(1,2)+1;
                end
            end
            for i = 1:length(T2)
                x = myTrans(T2(i,:)); 
                x1=g2(x,w11,w12);
                x2=g2(x,w21,w22);
                if(x1>x2)
                    confusion(2,1)=confusion(2,1)+1;
                else
                    confusion(2,2)=confusion(2,2)+1;
                end
            end
        elseif(classifier==2)
            cov = myCov([D1;D2],myMean([D1;D2]));
            w11 = myTrans(myMult(myInv(cov),mean1));
            w12 = - (0.5*myMult(myMult(myTrans(mean1),myInv(cov)),mean1)) + log(probc1);
            w21 = myTrans(myMult(myInv(cov),mean2));
            w22 = - (0.5*myMult(myMult(myTrans(mean2),myInv(cov)),mean2)) + log(probc2);
            for i = 1:length(T1)
                x = myTrans(T1(i,:)); 
                x1=g2(x,w11,w12);
                x2=g2(x,w21,w22);
                if(x1>x2)
                    confusion(1,1)=confusion(1,1)+1;
                else
                    confusion(1,2)=confusion(1,2)+1;
                end
            end
            for i = 1:length(T2)
                x = myTrans(T2(i,:)); 
                x1=g2(x,w11,w12);
                x2=g2(x,w21,w22);
                if(x1>x2)
                    confusion(2,1)=confusion(2,1)+1;
                else
                    confusion(2,2)=confusion(2,2)+1;
                end
            end
        elseif(classifier==3)
            w11 = myMult(myTrans(mean1),myInv(cov1));
            w12 = - (0.5*myMult(myMult(myTrans(mean1),myInv(cov1)),mean1)) + log(probc1) - (0.5*log(abs(myMod(cov1))));
            w21 = myMult(myTrans(mean2),myInv(cov2));
            w22 = - (0.5*myMult(myMult(myTrans(mean2),myInv(cov2)),mean2)) + log(probc2) - (0.5*log(abs(myMod(cov2))));
            for i = 1:length(T1)
                x = myTrans(T1(i,:)); 
                x1=g3(x,cov1,w11,w12);
                x2=g3(x,cov2,w21,w22);
                if(x1>x2)
                    confusion(1,1)=confusion(1,1)+1;
                else
                    confusion(1,2)=confusion(1,2)+1;
                end
            end
            for i = 1:length(T2)
                x = myTrans(T2(i,:)); 
                x1=g3(x,cov1,w11,w12);
                x2=g3(x,cov2,w21,w22);
                if(x1>x2)
                    confusion(2,1)=confusion(2,1)+1;
                else
                    confusion(2,2)=confusion(2,2)+1;
                end
            end
        elseif(classifier==4)
            cov = (cov1+cov2)/2;
            cov = diag(diag(cov));
            sigma=(cov(1,1)+cov(2,2))/2;
            cov(1,1)=sigma;
            cov(2,2)=sigma;
            w11 = myTrans(mean1)/sigma;
            w12 = (myMult(myTrans(mean1),mean1)/(((-2)*sigma*sigma))) + log(probc1) ;
            w21 = myTrans(mean2)/sigma;
            w22 = (myMult(myTrans(mean2),mean2)/(((-2)*sigma*sigma))) + log(probc2) ;
            for i = 1:length(T1)
                x = myTrans(T1(i,:)); 
                x1=g1(x,w11,w12);
                x2=g1(x,w21,w22);
                if(x1>x2)
                    confusion(1,1)=confusion(1,1)+1;
                else
                    confusion(1,2)=confusion(1,2)+1;
                end
            end
            for i = 1:length(T2)
                x = myTrans(T2(i,:)); 
                x1=g1(x,w11,w12);
                x2=g1(x,w21,w22);
                if(x1>x2)
                    confusion(2,1)=confusion(2,1)+1;
                else
                    confusion(2,2)=confusion(2,2)+1;
                end
            end
        elseif(classifier==5)
            cov = (cov1+cov2)/2;
            cov = diag(diag(cov));
            w11 = myTrans(myMult(myInv(cov),mean1));
            w12 = - (0.5*myMult(myMult(myTrans(mean1),myInv(cov)),mean1)) + log(probc1);
            w21 = myTrans(myMult(myInv(cov),mean2));
            w22 = - (0.5*myMult(myMult(myTrans(mean2),myInv(cov)),mean2)) + log(probc2);
            for i = 1:length(T1)
                x = myTrans(T1(i,:)); 
                x1=g2(x,w11,w12);
                x2=g2(x,w21,w22);
                if(x1>x2)
                    confusion(1,1)=confusion(1,1)+1;
                else
                    confusion(1,2)=confusion(1,2)+1;
                end
            end
            for i = 1:length(T2)
                x = myTrans(T2(i,:)); 
                x1=g2(x,w11,w12);
                x2=g2(x,w21,w22);
                if(x1>x2)
                    confusion(2,1)=confusion(2,1)+1;
                else
                    confusion(2,2)=confusion(2,2)+1;
                end
            end
        elseif(classifier==6)
            cov1=diag(diag(cov1));
            cov2=diag(diag(cov2));
            w11 = myMult(myTrans(mean1),myInv(cov1));
            w12 = - (0.5*myMult(myMult(myTrans(mean1),myInv(cov1)),mean1)) + log(probc1) - (0.5*log(abs(myMod(cov1))));
            w21 = myMult(myTrans(mean2),myInv(cov2));
            w22 = - (0.5*myMult(myMult(myTrans(mean2),myInv(cov2)),mean2)) + log(probc2) - (0.5*log(abs(myMod(cov2))));
            for i = 1:length(T1)
                x = myTrans(T1(i,:)); 
                x1=g3(x,cov1,w11,w12);
                x2=g3(x,cov2,w21,w22);
                if(x1>x2)
                    confusion(1,1)=confusion(1,1)+1;
                else
                    confusion(1,2)=confusion(1,2)+1;
                end
            end
            for i = 1:length(T2)
                x = myTrans(T2(i,:)); 
                x1=g3(x,cov1,w11,w12);
                x2=g3(x,cov2,w21,w22);
                if(x1>x2)
                    confusion(2,1)=confusion(2,1)+1;
                else
                    confusion(2,2)=confusion(2,2)+1;
                end
            end
        end
        N1 = length(T1);
        N2 = length(T2);
        N=N1+N2;
        TP1=confusion(1,1)+confusion(2,1);
        TP2=confusion(1,2)+confusion(2,2);
        TC1=confusion(1,1);
        TC2=confusion(2,2);
        Accuracy = (TC1+TC2)/N;
        Precision(1)=0;
        Precision(2)=0;
        if(TP1~=0)
            Precision(1) = TC1/TP1;
        end
        if(TP2~=0)
            Precision(2) = TC2/TP2;
        end
        MeanPrecision = (Precision(1)+Precision(2))/2;
        Recall(1) = TC1/N1;
        Recall(2) = TC2/N2;
        MeanRecall = (Recall(1)+Recall(2))/2;
        Fmeasure(1)=0;
        Fmeasure(2)=0;
        if(Precision(1)+Recall(1) ~= 0)
            Fmeasure(1) = (2*Precision(1)*Recall(1))/(Precision(1)+Recall(1));
        end
        if(Precision(2)+Recall(2) ~= 0)
            Fmeasure(2) = (2*Precision(2)*Recall(2))/(Precision(2)+Recall(2));
        end
        MeanFmeasure = (Fmeasure(1)+Fmeasure(2))/2;
        confusion
        Accuracy
        Precision
        MeanPrecision
        Recall
        MeanRecall
        Fmeasure
        MeanFmeasure
    else
        len=len1+len2+len3;
        probc1=len1/len;
        probc2=len2/len;
        probc3=len3/len;
        mean1 = myMean(D1);
        mean2 = myMean(D2);
        mean3 = myMean(D3);
        cov1 = myCov(D1,mean1);
        cov2 = myCov(D2,mean2);
        cov3 = myCov(D3,mean3);
        confusion=zeros(3,3);
        if(classifier==1)
            cov = (cov1+cov2+cov3)/2;
            w11 = myTrans(myMult(myInv(cov),mean1));
            w12 = - (0.5*myMult(myMult(myTrans(mean1),myInv(cov)),mean1)) + log(probc1);
            w21 = myTrans(myMult(myInv(cov),mean2));
            w22 = - (0.5*myMult(myMult(myTrans(mean2),myInv(cov)),mean2)) + log(probc2);
            w31 = myTrans(myMult(myInv(cov),mean3));
            w32 = - (0.5*myMult(myMult(myTrans(mean3),myInv(cov)),mean3)) + log(probc3);
            for i = 1:length(T1)
                x = myTrans(T1(i,:)); 
                x1=g2(x,w11,w12);
                x2=g2(x,w21,w22);
                x3=g2(x,w31,w32);
                if(x1>x2 && x1>x3)
                    confusion(1,1)=confusion(1,1)+1;
                elseif(x2>x1 && x2>x3)
                    confusion(1,2)=confusion(1,2)+1;
                elseif(x3>x1 && x3>x2)
                    confusion(1,3)=confusion(1,3)+1;
                end
            end
            for i = 1:length(T2)
                x = myTrans(T2(i,:)); 
                x1=g2(x,w11,w12);
                x2=g2(x,w21,w22);
                x3=g2(x,w31,w32);
                if(x1>x2 && x1>x3)
                    confusion(2,1)=confusion(2,1)+1;
                elseif(x2>x1 && x2>x3)
                    confusion(2,2)=confusion(2,2)+1;
                elseif(x3>x1 && x3>x2)
                    confusion(2,3)=confusion(2,3)+1;
                end
            end
            for i = 1:length(T3)
                x = myTrans(T3(i,:)); 
                x1=g2(x,w11,w12);
                x2=g2(x,w21,w22);
                x3=g2(x,w31,w32);
                if(x1>x2 && x1>x3)
                    confusion(3,1)=confusion(3,1)+1;
                elseif(x2>x1 && x2>x3)
                    confusion(3,2)=confusion(3,2)+1;
                elseif(x3>x1 && x3>x2)
                    confusion(3,3)=confusion(3,3)+1;
                end
            end
        elseif(classifier==2)
            cov = myCov([D1;D2;D3],myMean([D1;D2;D3]));
            w11 = myTrans(myMult(myInv(cov),mean1));
            w12 = - (0.5*myMult(myMult(myTrans(mean1),myInv(cov)),mean1)) + log(probc1);
            w21 = myTrans(myMult(myInv(cov),mean2));
            w22 = - (0.5*myMult(myMult(myTrans(mean2),myInv(cov)),mean2)) + log(probc2);
            w31 = myTrans(myMult(myInv(cov),mean3));
            w32 = - (0.5*myMult(myMult(myTrans(mean3),myInv(cov)),mean3)) + log(probc3);
            for i = 1:length(T1)
                x = myTrans(T1(i,:)); 
                x1=g2(x,w11,w12);
                x2=g2(x,w21,w22);
                x3=g2(x,w31,w32);
                if(x1>x2 && x1>x3)
                    confusion(1,1)=confusion(1,1)+1;
                elseif(x2>x1 && x2>x3)
                    confusion(1,2)=confusion(1,2)+1;
                elseif(x3>x1 && x3>x2)
                    confusion(1,3)=confusion(1,3)+1;
                end
            end
            for i = 1:length(T2)
                x = myTrans(T2(i,:)); 
                x1=g2(x,w11,w12);
                x2=g2(x,w21,w22);
                x3=g2(x,w31,w32);
                if(x1>x2 && x1>x3)
                    confusion(2,1)=confusion(2,1)+1;
                elseif(x2>x1 && x2>x3)
                    confusion(2,2)=confusion(2,2)+1;
                elseif(x3>x1 && x3>x2)
                    confusion(2,3)=confusion(2,3)+1;
                end
            end
            for i = 1:length(T3)
                x = myTrans(T3(i,:)); 
                x1=g2(x,w11,w12);
                x2=g2(x,w21,w22);
                x3=g2(x,w31,w32);
                if(x1>x2 && x1>x3)
                    confusion(3,1)=confusion(3,1)+1;
                elseif(x2>x1 && x2>x3)
                    confusion(3,2)=confusion(3,2)+1;
                elseif(x3>x1 && x3>x2)
                    confusion(3,3)=confusion(3,3)+1;
                end
            end
        elseif(classifier==3)
            w11 = myMult(myTrans(mean1),myInv(cov1));
            w12 = - (0.5*myMult(myMult(myTrans(mean1),myInv(cov1)),mean1)) + log(probc1) - (0.5*log(abs(myMod(cov1))));
            w21 = myMult(myTrans(mean2),myInv(cov2));
            w22 = - (0.5*myMult(myMult(myTrans(mean2),myInv(cov2)),mean2)) + log(probc2) - (0.5*log(abs(myMod(cov2))));
            w31 = myMult(myTrans(mean3),myInv(cov3));
            w32 = - (0.5*myMult(myMult(myTrans(mean3),myInv(cov3)),mean3)) + log(probc3) - (0.5*log(abs(myMod(cov3))));
            for i = 1:length(T1)
                x = myTrans(T1(i,:)); 
                x1=g3(x,cov1,w11,w12);
                x2=g3(x,cov2,w21,w22);
                x3=g3(x,cov3,w31,w32);
                if(x1>x2 && x1>x3)
                    confusion(1,1)=confusion(1,1)+1;
                elseif(x2>x1 && x2>x3)
                    confusion(1,2)=confusion(1,2)+1;
                elseif(x3>x1 && x3>x2)
                    confusion(1,3)=confusion(1,3)+1;
                end
            end
            for i = 1:length(T2)
                x = myTrans(T2(i,:)); 
                x1=g3(x,cov1,w11,w12);
                x2=g3(x,cov2,w21,w22);
                x3=g3(x,cov3,w31,w32);
                if(x1>x2 && x1>x3)
                    confusion(2,1)=confusion(2,1)+1;
                elseif(x2>x1 && x2>x3)
                    confusion(2,2)=confusion(2,2)+1;
                elseif(x3>x1 && x3>x2)
                    confusion(2,3)=confusion(2,3)+1;
                end
            end
            for i = 1:length(T3)
                x = myTrans(T3(i,:)); 
                x1=g3(x,cov1,w11,w12);
                x2=g3(x,cov2,w21,w22);
                x3=g3(x,cov3,w31,w32);
                if(x1>x2 && x1>x3)
                    confusion(3,1)=confusion(3,1)+1;
                elseif(x2>x1 && x2>x3)
                    confusion(3,2)=confusion(3,2)+1;
                elseif(x3>x1 && x3>x2)
                    confusion(3,3)=confusion(3,3)+1;
                end
            end
        elseif(classifier==4)
            cov = (cov1+cov2+cov3)/3;
            cov = diag(diag(cov));
            sigma=(cov(1,1)+cov(2,2))/2;
            cov(1,1)=sigma;
            cov(2,2)=sigma;
            w11 = myTrans(mean1)/sigma;
            w12 = (myMult(myTrans(mean1),mean1)/(((-2)*sigma*sigma))) + log(probc1) ;
            w21 = myTrans(mean2)/sigma;
            w22 = (myMult(myTrans(mean2),mean2)/(((-2)*sigma*sigma))) + log(probc2) ;
            w31 = myTrans(mean3)/sigma;
            w32 = (myMult(myTrans(mean3),mean3)/(((-2)*sigma*sigma))) + log(probc3) ;
            for i = 1:length(T1)
                x = myTrans(T1(i,:)); 
                x1=g1(x,w11,w12);
                x2=g1(x,w21,w22);
                x3=g1(x,w31,w32);
                if(x1>x2 && x1>x3)
                    confusion(1,1)=confusion(1,1)+1;
                elseif(x2>x1 && x2>x3)
                    confusion(1,2)=confusion(1,2)+1;
                elseif(x3>x1 && x3>x2)
                    confusion(1,3)=confusion(1,3)+1;
                end
            end
            for i = 1:length(T2)
                x = myTrans(T2(i,:)); 
                x1=g1(x,w11,w12);
                x2=g1(x,w21,w22);
                x3=g1(x,w31,w32);
                if(x1>x2 && x1>x3)
                    confusion(2,1)=confusion(2,1)+1;
                elseif(x2>x1 && x2>x3)
                    confusion(2,2)=confusion(2,2)+1;
                elseif(x3>x1 && x3>x2)
                    confusion(2,3)=confusion(2,3)+1;
                end
            end
            for i = 1:length(T3)
                x = myTrans(T3(i,:)); 
                x1=g1(x,w11,w12);
                x2=g1(x,w21,w22);
                x3=g1(x,w31,w32);
                if(x1>x2 && x1>x3)
                    confusion(3,1)=confusion(3,1)+1;
                elseif(x2>x1 && x2>x3)
                    confusion(3,2)=confusion(3,2)+1;
                elseif(x3>x1 && x3>x2)
                    confusion(3,3)=confusion(3,3)+1;
                end
            end
        elseif(classifier==5)
            cov = (cov1+cov2+cov3)/2;
            cov=diag(diag(cov));
            w11 = myTrans(myMult(myInv(cov),mean1));
            w12 = - (0.5*myMult(myMult(myTrans(mean1),myInv(cov)),mean1)) + log(probc1);
            w21 = myTrans(myMult(myInv(cov),mean2));
            w22 = - (0.5*myMult(myMult(myTrans(mean2),myInv(cov)),mean2)) + log(probc2);
            w31 = myTrans(myMult(myInv(cov),mean3));
            w32 = - (0.5*myMult(myMult(myTrans(mean3),myInv(cov)),mean3)) + log(probc3);
            for i = 1:length(T1)
                x = myTrans(T1(i,:)); 
                x1=g2(x,w11,w12);
                x2=g2(x,w21,w22);
                x3=g2(x,w31,w32);
                if(x1>x2 && x1>x3)
                    confusion(1,1)=confusion(1,1)+1;
                elseif(x2>x1 && x2>x3)
                    confusion(1,2)=confusion(1,2)+1;
                elseif(x3>x1 && x3>x2)
                    confusion(1,3)=confusion(1,3)+1;
                end
            end
            for i = 1:length(T2)
                x = myTrans(T2(i,:)); 
                x1=g2(x,w11,w12);
                x2=g2(x,w21,w22);
                x3=g2(x,w31,w32);
                if(x1>x2 && x1>x3)
                    confusion(2,1)=confusion(2,1)+1;
                elseif(x2>x1 && x2>x3)
                    confusion(2,2)=confusion(2,2)+1;
                elseif(x3>x1 && x3>x2)
                    confusion(2,3)=confusion(2,3)+1;
                end
            end
            for i = 1:length(T3)
                x = myTrans(T3(i,:)); 
                x1=g2(x,w11,w12);
                x2=g2(x,w21,w22);
                x3=g2(x,w31,w32);
                if(x1>x2 && x1>x3)
                    confusion(3,1)=confusion(3,1)+1;
                elseif(x2>x1 && x2>x3)
                    confusion(3,2)=confusion(3,2)+1;
                elseif(x3>x1 && x3>x2)
                    confusion(3,3)=confusion(3,3)+1;
                end
            end
        elseif(classifier==6)
            cov1=diag(diag(cov1));
            cov2=diag(diag(cov2));
            cov3=diag(diag(cov3));
            w11 = myMult(myTrans(mean1),myInv(cov1));
            w12 = - (0.5*myMult(myMult(myTrans(mean1),myInv(cov1)),mean1)) + log(probc1) - (0.5*log(abs(myMod(cov1))));
            w21 = myMult(myTrans(mean2),myInv(cov2));
            w22 = - (0.5*myMult(myMult(myTrans(mean2),myInv(cov2)),mean2)) + log(probc2) - (0.5*log(abs(myMod(cov2))));
            w31 = myMult(myTrans(mean3),myInv(cov3));
            w32 = - (0.5*myMult(myMult(myTrans(mean3),myInv(cov3)),mean3)) + log(probc3) - (0.5*log(abs(myMod(cov3))));
            for i = 1:length(T1)
                x = myTrans(T1(i,:)); 
                x1=g3(x,cov1,w11,w12);
                x2=g3(x,cov2,w21,w22);
                x3=g3(x,cov3,w31,w32);
                if(x1>x2 && x1>x3)
                    confusion(1,1)=confusion(1,1)+1;
                elseif(x2>x1 && x2>x3)
                    confusion(1,2)=confusion(1,2)+1;
                elseif(x3>x1 && x3>x2)
                    confusion(1,3)=confusion(1,3)+1;
                end
            end
            for i = 1:length(T2)
                x = myTrans(T2(i,:)); 
                x1=g3(x,cov1,w11,w12);
                x2=g3(x,cov2,w21,w22);
                x3=g3(x,cov3,w31,w32);
                if(x1>x2 && x1>x3)
                    confusion(2,1)=confusion(2,1)+1;
                elseif(x2>x1 && x2>x3)
                    confusion(2,2)=confusion(2,2)+1;
                elseif(x3>x1 && x3>x2)
                    confusion(2,3)=confusion(2,3)+1;
                end
            end
            for i = 1:length(T3)
                x = myTrans(T3(i,:)); 
                x1=g3(x,cov1,w11,w12);
                x2=g3(x,cov2,w21,w22);
                x3=g3(x,cov3,w31,w32);
                if(x1>x2 && x1>x3)
                    confusion(3,1)=confusion(3,1)+1;
                elseif(x2>x1 && x2>x3)
                    confusion(3,2)=confusion(3,2)+1;
                elseif(x3>x1 && x3>x2)
                    confusion(3,3)=confusion(3,3)+1;
                end
            end
        end
        N1 = length(T1);
        N2 = length(T2);
        N3 = length(T3);
        N=N1+N2+N3;
        TP1=confusion(1,1)+confusion(2,1)+confusion(3,1);
        TP2=confusion(1,2)+confusion(2,2)+confusion(3,2);
        TP3=confusion(1,3)+confusion(2,3)+confusion(3,3);
        TC1=confusion(1,1);
        TC2=confusion(2,2);
        TC3=confusion(3,3);
        Precision(1)=0;
        Precision(2)=0;
        Precision(3)=0;
        Accuracy = (TC1+TC2+TC3)/N;
        if(TP1~=0)
            Precision(1) = TC1/TP1;
        end
        if(TP2~=0)
            Precision(2) = TC2/TP2;
        end
        if(TP3~=0)
            Precision(3) = TC3/TP3;
        end
        MeanPrecision = (Precision(1)+Precision(2)+Precision(3))/3;
        Recall(1) = TC1/N1;
        Recall(2) = TC2/N2;
        Recall(3) = TC3/N3;
        MeanRecall = (Recall(1)+Recall(2)+Recall(3))/3;
        Fmeasure(1)=0;
        Fmeasure(2)=0;
        Fmeasure(3)=0;
        if(Precision(1)+Recall(1) ~= 0)
            Fmeasure(1) = (2*Precision(1)*Recall(1))/(Precision(1)+Recall(1));
        end
        if(Precision(2)+Recall(2) ~= 0)
            Fmeasure(2) = (2*Precision(2)*Recall(2))/(Precision(2)+Recall(2));
        end
        if(Precision(3)+Recall(3) ~= 0)
            Fmeasure(3) = (2*Precision(3)*Recall(3))/(Precision(3)+Recall(3));
        end
        MeanFmeasure = (Fmeasure(1)+Fmeasure(2)+Fmeasure(3))/3;
        confusion
        Accuracy
        Precision
        MeanPrecision
        Recall
        MeanRecall
        Fmeasure
        MeanFmeasure
    end
end    