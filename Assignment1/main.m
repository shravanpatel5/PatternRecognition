function main(folder,numofclasses,classifier,name)
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
        X1 = D1(:,1);
        Y1 = D1(:,2);
        X2 = D2(:,1);
        Y2 = D2(:,2);
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
                    X1=[X1 ;x(1)];
                    Y1=[Y1 ;x(2)];
                else
                    confusion(1,2)=confusion(1,2)+1;
                    X2=[X2 ;x(1)];
                    Y2=[Y2 ;x(2)];
                end
            end
            for i = 1:length(T2)
                x = myTrans(T2(i,:)); 
                x1=g2(x,w11,w12);
                x2=g2(x,w21,w22);
                if(x1>x2)
                    confusion(2,1)=confusion(2,1)+1;
                    X1=[X1 ;x(1)];
                    Y1=[Y1 ;x(2)];
                else
                    confusion(2,2)=confusion(2,2)+1;
                    X2=[X2 ;x(1)];
                    Y2=[Y2 ;x(2)];
                end
            end
            maxX=max(max(X1),max(X2));
            minX=min(min(X1),min(X2));
            maxY=max(max(Y1),max(Y2));
            minY=min(min(Y1),min(Y2));
            minX=minX-1;
            maxX=maxX+1;
            minY=minY-1;
            maxY=maxY+1;
            incX=(maxX-minX)/150;
            incY=(maxY-minY)/150;
            BX1=0;
            BY1=0;
            BX2=0;
            BY2=0;
            row=0;
            for bgx = minX:incX:maxX
                row = row+1;
                col=0;
                for bgy = minY:incY:maxY
                    col = col+1;;
                    CX(row,col)=bgx;
                    CY(row,col)=bgy;
                    x=[bgx;bgy];
                    x1=g2(x,w11,w12);
                    x2=g2(x,w21,w22);
                    CZ1(row,col)=(x1*100);
                    CZ2(row,col)=(x2*100);
                    if(x1>x2)
                        BX1=[BX1 ;x(1)];
                        BY1=[BY1 ;x(2)];
                    else
                        BX2=[BX2 ;x(1)];
                        BY2=[BY2 ;x(2)];
                    end
                end
            end
            BX1 = BX1(2:length(BX1));
            BX2 = BX2(2:length(BX2));
            BY1 = BY1(2:length(BY1));
            BY2 = BY2(2:length(BY2));
            plot(BX1,BY1,'.','Color',[1 .5 .5]),hold on,plot(BX2,BY2,'.','Color',[.5 .5 1]),plot(X1,Y1,'r.',X2,Y2,'b.'),axis([minX maxX minY maxY]),xlabel('x'),ylabel('y'),title(strcat(name,'-AllClasses')),legend('Class1','Class2'),set(gca,'Color',[1 1 1]),hold off;
            figure
            contour(CX,CY,CZ1,'r'),hold on,contour(CX,CY,CZ2,'b'),legend('Class1','Class2'),xlabel('x'),ylabel('y'),title(strcat(name,'-Contour')),hold off
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
                    X1=[X1 ;x(1)];
                    Y1=[Y1 ;x(2)];
                else
                    confusion(1,2)=confusion(1,2)+1;
                    X2=[X2 ;x(1)];
                    Y2=[Y2 ;x(2)];
                end
            end
            for i = 1:length(T2)
                x = myTrans(T2(i,:)); 
                x1=g2(x,w11,w12);
                x2=g2(x,w21,w22);
                if(x1>x2)
                    confusion(2,1)=confusion(2,1)+1;
                    X1=[X1 ;x(1)];
                    Y1=[Y1 ;x(2)];
                else
                    confusion(2,2)=confusion(2,2)+1;
                    X2=[X2 ;x(1)];
                    Y2=[Y2 ;x(2)];
                end
            end
            maxX=max(max(X1),max(X2));
            minX=min(min(X1),min(X2));
            maxY=max(max(Y1),max(Y2));
            minY=min(min(Y1),min(Y2));
            minX=minX-1;
            maxX=maxX+1;
            minY=minY-1;
            maxY=maxY+1;
            incX=(maxX-minX)/150;
            incY=(maxY-minY)/150;
            BX1=0;
            BY1=0;
            BX2=0;
            BY2=0;
            row=0;
            for bgx = minX:incX:maxX
                row = row+1;
                col=0;
                for bgy = minY:incY:maxY
                    col = col+1;;
                    CX(row,col)=bgx;
                    CY(row,col)=bgy;
                    x=[bgx;bgy];
                    x1=g2(x,w11,w12);
                    x2=g2(x,w21,w22);
                    CZ1(row,col)=(x1*100);
                    CZ2(row,col)=(x2*100);
                    if(x1>x2)
                        BX1=[BX1 ;x(1)];
                        BY1=[BY1 ;x(2)];
                    else
                        BX2=[BX2 ;x(1)];
                        BY2=[BY2 ;x(2)];
                    end
                end
            end
            BX1 = BX1(2:length(BX1));
            BX2 = BX2(2:length(BX2));
            BY1 = BY1(2:length(BY1));
            BY2 = BY2(2:length(BY2));
            plot(BX1,BY1,'.','Color',[1 .5 .5]),hold on,plot(BX2,BY2,'.','Color',[.5 .5 1]),plot(X1,Y1,'r.',X2,Y2,'b.'),axis([minX maxX minY maxY]),xlabel('x'),ylabel('y'),title(strcat(name,'-AllClasses')),legend('Class1','Class2'),set(gca,'Color',[1 1 1]),hold off;
            figure
            contour(CX,CY,CZ1,'r'),hold on,contour(CX,CY,CZ2,'b'),legend('Class1','Class2'),xlabel('x'),ylabel('y'),title(strcat(name,'-Contour')),hold off
        elseif(classifier==3)
            w11 = myTrans(myMult(myInv(cov1),mean1));
            w12 = - (0.5*myMult(myMult(myTrans(mean1),myInv(cov1)),mean1)) + log(probc1) - (0.5*log(abs(myMod(cov1))));
            w21 = myTrans(myMult(myInv(cov2),mean2));
            w22 = - (0.5*myMult(myMult(myTrans(mean2),myInv(cov2)),mean2)) + log(probc2) - (0.5*log(abs(myMod(cov2))));
            for i = 1:length(T1)
                x = myTrans(T1(i,:)); 
                x1=g3(x,cov1,w11,w12);
                x2=g3(x,cov2,w21,w22);
                if(x1>x2)
                    confusion(1,1)=confusion(1,1)+1;
                    X1=[X1 ;x(1)];
                    Y1=[Y1 ;x(2)];
                else
                    confusion(1,2)=confusion(1,2)+1;
                    X2=[X2 ;x(1)];
                    Y2=[Y2 ;x(2)];
                end
            end
            for i = 1:length(T2)
                x = myTrans(T2(i,:)); 
                x1=g3(x,cov1,w11,w12);
                x2=g3(x,cov2,w21,w22);
                if(x1>x2)
                    confusion(2,1)=confusion(2,1)+1;
                    X1=[X1 ;x(1)];
                    Y1=[Y1 ;x(2)];
                else
                    confusion(2,2)=confusion(2,2)+1;
                    X2=[X2 ;x(1)];
                    Y2=[Y2 ;x(2)];
                end
            end
            maxX=max(max(X1),max(X2));
            minX=min(min(X1),min(X2));
            maxY=max(max(Y1),max(Y2));
            minY=min(min(Y1),min(Y2));
            minX=minX-1;
            maxX=maxX+1;
            minY=minY-1;
            maxY=maxY+1;
            incX=(maxX-minX)/150;
            incY=(maxY-minY)/150;
            BX1=0;
            BY1=0;
            BX2=0;
            BY2=0;
            row=0;
            for bgx = minX:incX:maxX
                row = row+1;
                col=0;
                for bgy = minY:incY:maxY
                    col = col+1;;
                    CX(row,col)=bgx;
                    CY(row,col)=bgy;
                    x=[bgx;bgy];
                    x1=g3(x,cov1,w11,w12);
                    x2=g3(x,cov2,w21,w22);
                    CZ1(row,col)=(x1*100);
                    CZ2(row,col)=(x2*100);
                    if(x1>x2)
                        BX1=[BX1 ;x(1)];
                        BY1=[BY1 ;x(2)];
                    else
                        BX2=[BX2 ;x(1)];
                        BY2=[BY2 ;x(2)];
                    end
                end
            end
            BX1 = BX1(2:length(BX1));
            BX2 = BX2(2:length(BX2));
            BY1 = BY1(2:length(BY1));
            BY2 = BY2(2:length(BY2));
            plot(BX1,BY1,'.','Color',[1 .5 .5]),hold on,plot(BX2,BY2,'.','Color',[.5 .5 1]),plot(X1,Y1,'r.',X2,Y2,'b.'),axis([minX maxX minY maxY]),xlabel('x'),ylabel('y'),title(strcat(name,'-AllClasses')),legend('Class1','Class2'),set(gca,'Color',[1 1 1]),hold off;
            figure
            contour(CX,CY,CZ1,'r'),hold on,contour(CX,CY,CZ2,'b'),legend('Class1','Class2'),xlabel('x'),ylabel('y'),title(strcat(name,'-Contour')),hold off
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
                    X1=[X1 ;x(1)];
                    Y1=[Y1 ;x(2)];
                else
                    confusion(1,2)=confusion(1,2)+1;
                    X2=[X2 ;x(1)];
                    Y2=[Y2 ;x(2)];
                end
            end
            for i = 1:length(T2)
                x = myTrans(T2(i,:)); 
                x1=g1(x,w11,w12);
                x2=g1(x,w21,w22);
                if(x1>x2)
                    confusion(2,1)=confusion(2,1)+1;
                    X1=[X1 ;x(1)];
                    Y1=[Y1 ;x(2)];
                else
                    confusion(2,2)=confusion(2,2)+1;
                    X2=[X2 ;x(1)];
                    Y2=[Y2 ;x(2)];
                end
            end
            maxX=max(max(X1),max(X2));
            minX=min(min(X1),min(X2));
            maxY=max(max(Y1),max(Y2));
            minY=min(min(Y1),min(Y2));
            minX=minX-1;
            maxX=maxX+1;
            minY=minY-1;
            maxY=maxY+1;
            incX=(maxX-minX)/150;
            incY=(maxY-minY)/150;
            BX1=0;
            BY1=0;
            BX2=0;
            BY2=0;
            row=0;
            for bgx = minX:incX:maxX
                row = row+1;
                col=0;
                for bgy = minY:incY:maxY
                    col = col+1;;
                    CX(row,col)=bgx;
                    CY(row,col)=bgy;
                    x=[bgx;bgy];
                    x1=g1(x,w11,w12);
                    x2=g1(x,w21,w22);
                    CZ1(row,col)=(x1*100);
                    CZ2(row,col)=(x2*100);
                    if(x1>x2)
                        BX1=[BX1 ;x(1)];
                        BY1=[BY1 ;x(2)];
                    else
                        BX2=[BX2 ;x(1)];
                        BY2=[BY2 ;x(2)];
                    end
                end
            end
            BX1 = BX1(2:length(BX1));
            BX2 = BX2(2:length(BX2));
            BY1 = BY1(2:length(BY1));
            BY2 = BY2(2:length(BY2));
            plot(BX1,BY1,'.','Color',[1 .5 .5]),hold on,plot(BX2,BY2,'.','Color',[.5 .5 1]),plot(X1,Y1,'r.',X2,Y2,'b.'),axis([minX maxX minY maxY]),xlabel('x'),ylabel('y'),title(strcat(name,'-AllClasses')),legend('Class1','Class2'),set(gca,'Color',[1 1 1]),hold off;
            figure
            contour(CX,CY,CZ1,'r'),hold on,contour(CX,CY,CZ2,'b'),legend('Class1','Class2'),xlabel('x'),ylabel('y'),title(strcat(name,'-Contour')),hold off
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
                    X1=[X1 ;x(1)];
                    Y1=[Y1 ;x(2)];
                else
                    confusion(1,2)=confusion(1,2)+1;
                    X2=[X2 ;x(1)];
                    Y2=[Y2 ;x(2)];
                end
            end
            for i = 1:length(T2)
                x = myTrans(T2(i,:)); 
                x1=g2(x,w11,w12);
                x2=g2(x,w21,w22);
                if(x1>x2)
                    confusion(2,1)=confusion(2,1)+1;
                    X1=[X1 ;x(1)];
                    Y1=[Y1 ;x(2)];
                else
                    confusion(2,2)=confusion(2,2)+1;
                    X2=[X2 ;x(1)];
                    Y2=[Y2 ;x(2)];
                end
            end
            maxX=max(max(X1),max(X2));
            minX=min(min(X1),min(X2));
            maxY=max(max(Y1),max(Y2));
            minY=min(min(Y1),min(Y2));
            minX=minX-1;
            maxX=maxX+1;
            minY=minY-1;
            maxY=maxY+1;
            incX=(maxX-minX)/150;
            incY=(maxY-minY)/150;
            BX1=0;
            BY1=0;
            BX2=0;
            BY2=0;
            row=0;
            for bgx = minX:incX:maxX
                row = row+1;
                col=0;
                for bgy = minY:incY:maxY
                    col = col+1;;
                    CX(row,col)=bgx;
                    CY(row,col)=bgy;
                    x=[bgx;bgy];
                    x1=g2(x,w11,w12);
                    x2=g2(x,w21,w22);
                    CZ1(row,col)=(x1*100);
                    CZ2(row,col)=(x2*100);
                    if(x1>x2)
                        BX1=[BX1 ;x(1)];
                        BY1=[BY1 ;x(2)];
                    else
                        BX2=[BX2 ;x(1)];
                        BY2=[BY2 ;x(2)];
                    end
                end
            end
            BX1 = BX1(2:length(BX1));
            BX2 = BX2(2:length(BX2));
            BY1 = BY1(2:length(BY1));
            BY2 = BY2(2:length(BY2));
            plot(BX1,BY1,'.','Color',[1 .5 .5]),hold on,plot(BX2,BY2,'.','Color',[.5 .5 1]),plot(X1,Y1,'r.',X2,Y2,'b.'),axis([minX maxX minY maxY]),xlabel('x'),ylabel('y'),title(strcat(name,'-AllClasses')),legend('Class1','Class2'),set(gca,'Color',[1 1 1]),hold off;
            figure
            contour(CX,CY,CZ1,'r'),hold on,contour(CX,CY,CZ2,'b'),legend('Class1','Class2'),xlabel('x'),ylabel('y'),title(strcat(name,'-Contour')),hold off
        elseif(classifier==6)
            cov1=diag(diag(cov1));
            cov2=diag(diag(cov2));
            w11 = myTrans(myMult(myInv(cov1),mean1));
            w12 = - (0.5*myMult(myMult(myTrans(mean1),myInv(cov1)),mean1)) + log(probc1) - (0.5*log(abs(myMod(cov1))));
            w21 = myTrans(myMult(myInv(cov2),mean2));
            w22 = - (0.5*myMult(myMult(myTrans(mean2),myInv(cov2)),mean2)) + log(probc2) - (0.5*log(abs(myMod(cov2))));
            for i = 1:length(T1)
                x = myTrans(T1(i,:)); 
                x1=g3(x,cov1,w11,w12);
                x2=g3(x,cov2,w21,w22);
                if(x1>x2)
                    confusion(1,1)=confusion(1,1)+1;
                    X1=[X1 ;x(1)];
                    Y1=[Y1 ;x(2)];
                else
                    confusion(1,2)=confusion(1,2)+1;
                    X2=[X2 ;x(1)];
                    Y2=[Y2 ;x(2)];
                end
            end
            for i = 1:length(T2)
                x = myTrans(T2(i,:)); 
                x1=g3(x,cov1,w11,w12);
                x2=g3(x,cov2,w21,w22);
                if(x1>x2)
                    confusion(2,1)=confusion(2,1)+1;
                    X1=[X1 ;x(1)];
                    Y1=[Y1 ;x(2)];
                else
                    confusion(2,2)=confusion(2,2)+1;
                    X2=[X2 ;x(1)];
                    Y2=[Y2 ;x(2)];
                end
            end
            maxX=max(max(X1),max(X2));
            minX=min(min(X1),min(X2));
            maxY=max(max(Y1),max(Y2));
            minY=min(min(Y1),min(Y2));
            minX=minX-1;
            maxX=maxX+1;
            minY=minY-1;
            maxY=maxY+1;
            incX=(maxX-minX)/150;
            incY=(maxY-minY)/150;
            BX1=0;
            BY1=0;
            BX2=0;
            BY2=0;
            row=0;
            for bgx = minX:incX:maxX
                row = row+1;
                col=0;
                for bgy = minY:incY:maxY
                    col = col+1;;
                    CX(row,col)=bgx;
                    CY(row,col)=bgy;
                    x=[bgx;bgy];
                    x1=g3(x,cov1,w11,w12);
                    x2=g3(x,cov2,w21,w22);
                    CZ1(row,col)=(x1*100);
                    CZ2(row,col)=(x2*100);
                    if(x1>x2)
                        BX1=[BX1 ;x(1)];
                        BY1=[BY1 ;x(2)];
                    else
                        BX2=[BX2 ;x(1)];
                        BY2=[BY2 ;x(2)];
                    end
                end
            end
            BX1 = BX1(2:length(BX1));
            BX2 = BX2(2:length(BX2));
            BY1 = BY1(2:length(BY1));
            BY2 = BY2(2:length(BY2));
            plot(BX1,BY1,'.','Color',[1 .5 .5]),hold on,plot(BX2,BY2,'.','Color',[.5 .5 1]),plot(X1,Y1,'r.',X2,Y2,'b.'),axis([minX maxX minY maxY]),xlabel('x'),ylabel('y'),title(strcat(name,'-AllClasses')),legend('Class1','Class2'),set(gca,'Color',[1 1 1]),hold off;
            figure
            contour(CX,CY,CZ1,'r'),hold on,contour(CX,CY,CZ2,'b'),legend('Class1','Class2'),xlabel('x'),ylabel('y'),title(strcat(name,'-Contour')),hold off
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
        X1 = D1(:,1);
        Y1 = D1(:,2);
        X2 = D2(:,1);
        Y2 = D2(:,2);
        X3 = D3(:,1);
        Y3 = D3(:,2);
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
                    X1=[X1 ;x(1)];
                    Y1=[Y1 ;x(2)];
                elseif(x2>x1 && x2>x3)
                    confusion(1,2)=confusion(1,2)+1;
                    X2=[X2 ;x(1)];
                    Y2=[Y2 ;x(2)];
                elseif(x3>x1 && x3>x2)
                    confusion(1,3)=confusion(1,3)+1;
                    X3=[X3 ;x(1)];
                    Y3=[Y3 ;x(2)];
                end
            end
            for i = 1:length(T2)
                x = myTrans(T2(i,:)); 
                x1=g2(x,w11,w12);
                x2=g2(x,w21,w22);
                x3=g2(x,w31,w32);
                if(x1>x2 && x1>x3)
                    confusion(2,1)=confusion(2,1)+1;
                    X1=[X1 ;x(1)];
                    Y1=[Y1 ;x(2)];
                elseif(x2>x1 && x2>x3)
                    confusion(2,2)=confusion(2,2)+1;
                    X2=[X2 ;x(1)];
                    Y2=[Y2 ;x(2)];
                elseif(x3>x1 && x3>x2)
                    confusion(2,3)=confusion(2,3)+1;
                    X3=[X3 ;x(1)];
                    Y3=[Y3 ;x(2)];
                end
            end
            for i = 1:length(T3)
                x = myTrans(T3(i,:)); 
                x1=g2(x,w11,w12);
                x2=g2(x,w21,w22);
                x3=g2(x,w31,w32);
                if(x1>x2 && x1>x3)
                    X1=[X1 ;x(1)];
                    Y1=[Y1 ;x(2)];
                    confusion(3,1)=confusion(3,1)+1;
                elseif(x2>x1 && x2>x3)
                    X2=[X2 ;x(1)];
                    Y2=[Y2 ;x(2)];
                    confusion(3,2)=confusion(3,2)+1;
                elseif(x3>x1 && x3>x2)
                    X3=[X3 ;x(1)];
                    Y3=[Y3 ;x(2)];
                    confusion(3,3)=confusion(3,3)+1;
                end
            end
            maxX=max(max(X1),max(X2));
            minX=min(min(X1),min(X2));
            maxY=max(max(Y1),max(Y2));
            minY=min(min(Y1),min(Y2));
            minX=minX-1;
            maxX=maxX+1;
            minY=minY-1;
            maxY=maxY+1;
            incX=(maxX-minX)/150;
            incY=(maxY-minY)/150;
            BX1=0;
            BY1=0;
            BY3=0;
            BX3=0;
            BX2=0;
            BY2=0;
            row=0;
            for bgx = minX:incX:maxX
                row = row+1;
                col=0;
                for bgy = minY:incY:maxY
                    col = col+1;;
                    CX(row,col)=bgx;
                    CY(row,col)=bgy;
                    x=[bgx;bgy];
                    x1=g2(x,w11,w12);
                    x2=g2(x,w21,w22);
                    x3=g2(x,w31,w32);
                    CZ1(row,col)=(x1);
                    CZ2(row,col)=(x2);
                    CZ3(row,col)=(x3);
                    if(x1>x2 && x1>x3)
                        BX1=[BX1 ;x(1)];
                        BY1=[BY1 ;x(2)];
                    elseif(x2>x1 && x2>x3)
                        BX2=[BX2 ;x(1)];
                        BY2=[BY2 ;x(2)];
                    elseif(x3>x1 && x3>x2)
                        BX3=[BX3 ;x(1)];
                        BY3=[BY3 ;x(2)];
                    end
                end
            end
            BX1 = BX1(2:length(BX1));
            BX2 = BX2(2:length(BX2));
            BX3 = BX3(2:length(BX3));
            BY1 = BY1(2:length(BY1));
            BY2 = BY2(2:length(BY2));
            BY3 = BY3(2:length(BY3));
            plot(BX1,BY1,'.','Color',[1 0.5 0.5 ]),hold on,plot(BX2,BY2,'.','Color',[0.5 0.5 1]),plot(BX3,BY3,'.','Color',[0.5 1 .5]),plot(X1,Y1,'r.',X2,Y2,'b.',X3,Y3,'g.'),legend('Class1','Class2','Class3'),axis([minX maxX minY maxY]),xlabel('x'),ylabel('y'),title(strcat(name,'-AllClasses'));
            figure
            contour(CX,CY,CZ1,'r'),hold on,contour(CX,CY,CZ2,'b'),contour(CX,CY,CZ3,'g'),legend('Class1','Class2','Class3'),title(strcat(name,'-Contour')),xlabel('x'),ylabel('y'),hold off
            
            %A and B
            
            len=len1+len2;
            probc1=len1/len;
            probc2=len2/len;
            cov = (cov1+cov2)/2;
            X1 = D1(:,1);
            Y1 = D1(:,2);
            X2 = D2(:,1);
            Y2 = D2(:,2);
            w11 = myTrans(myMult(myInv(cov),mean1));
            w12 = - (0.5*myMult(myMult(myTrans(mean1),myInv(cov)),mean1)) + log(probc1);
            w21 = myTrans(myMult(myInv(cov),mean2));
            w22 = - (0.5*myMult(myMult(myTrans(mean2),myInv(cov)),mean2)) + log(probc2);
            for i = 1:length(T1)
                x = myTrans(T1(i,:)); 
                x1=g2(x,w11,w12);
                x2=g2(x,w21,w22);
                if(x1>x2)
                    X1=[X1 ;x(1)];
                    Y1=[Y1 ;x(2)];
                else
                    X2=[X2 ;x(1)];
                    Y2=[Y2 ;x(2)];
                end
            end
            for i = 1:length(T2)
                x = myTrans(T2(i,:)); 
                x1=g2(x,w11,w12);
                x2=g2(x,w21,w22);
                if(x1>x2)
                    X1=[X1 ;x(1)];
                    Y1=[Y1 ;x(2)];
                else
                    X2=[X2 ;x(1)];
                    Y2=[Y2 ;x(2)];
                end
            end
            BX1=0;
            BY1=0;
            BX2=0;
            BY2=0;
            row=0;
            for bgx = minX:incX:maxX
                for bgy = minY:incY:maxY
                    x=[bgx;bgy];
                    x1=g2(x,w11,w12);
                    x2=g2(x,w21,w22);
                    if(x1>x2)
                        BX1=[BX1 ;x(1)];
                        BY1=[BY1 ;x(2)];
                    else
                        BX2=[BX2 ;x(1)];
                        BY2=[BY2 ;x(2)];
                    end
                end
            end
            BX1 = BX1(2:length(BX1));
            BX2 = BX2(2:length(BX2));
            BY1 = BY1(2:length(BY1));
            BY2 = BY2(2:length(BY2));
            figure
            plot(BX1,BY1,'.','Color',[1 0.5 0.5 ]),hold on,plot(BX2,BY2,'.','Color',[0.5 0.5 1]),plot(X1,Y1,'r.',X2,Y2,'b.'),legend('Class1','Class2'),axis([minX maxX minY maxY]),xlabel('x'),ylabel('y'),title(strcat(name,'-Classes:1&2'));
            
            %B & C 
            
            len=len3+len2;
            probc3=len3/len;
            probc2=len2/len;
            cov = (cov3+cov2)/2;
            X1 = D3(:,1);
            Y1 = D3(:,2);
            X2 = D2(:,1);
            Y2 = D2(:,2);
            w11 = myTrans(myMult(myInv(cov),mean3));
            w12 = - (0.5*myMult(myMult(myTrans(mean3),myInv(cov)),mean3)) + log(probc3);
            w21 = myTrans(myMult(myInv(cov),mean2));
            w22 = - (0.5*myMult(myMult(myTrans(mean2),myInv(cov)),mean2)) + log(probc2);
            for i = 1:length(T3)
                x = myTrans(T3(i,:)); 
                x1=g2(x,w11,w12);
                x2=g2(x,w21,w22);
                if(x1>x2)
                    X1=[X1 ;x(1)];
                    Y1=[Y1 ;x(2)];
                else
                    X2=[X2 ;x(1)];
                    Y2=[Y2 ;x(2)];
                end
            end
            for i = 1:length(T2)
                x = myTrans(T2(i,:)); 
                x1=g2(x,w11,w12);
                x2=g2(x,w21,w22);
                if(x1>x2)
                    X1=[X1 ;x(1)];
                    Y1=[Y1 ;x(2)];
                else
                    X2=[X2 ;x(1)];
                    Y2=[Y2 ;x(2)];
                end
            end
            BX1=0;
            BY1=0;
            BX2=0;
            BY2=0;
            row=0;
            for bgx = minX:incX:maxX
                for bgy = minY:incY:maxY
                    x=[bgx;bgy];
                    x1=g2(x,w11,w12);
                    x2=g2(x,w21,w22);
                    if(x1>x2)
                        BX1=[BX1 ;x(1)];
                        BY1=[BY1 ;x(2)];
                    else
                        BX2=[BX2 ;x(1)];
                        BY2=[BY2 ;x(2)];
                    end
                end
            end
            BX1 = BX1(2:length(BX1));
            BX2 = BX2(2:length(BX2));
            BY1 = BY1(2:length(BY1));
            BY2 = BY2(2:length(BY2));
            figure
            plot(BX2,BY2,'.','Color',[0.5 0.5 1]),hold on,plot(BX1,BY1,'.','Color',[0.5 1 0.5 ]),plot(X2,Y2,'b.',X1,Y1,'g.'),legend('Class2','Class3'),axis([minX maxX minY maxY]),xlabel('x'),ylabel('y'),title(strcat(name,'-Classes:2&3'));
            
            % A & C
            
            len=len1+len3;
            probc1=len1/len;
            probc3=len3/len;
            cov = (cov1+cov3)/2;
            X1 = D1(:,1);
            Y1 = D1(:,2);
            X2 = D3(:,1);
            Y2 = D3(:,2);
            w11 = myTrans(myMult(myInv(cov),mean1));
            w12 = - (0.5*myMult(myMult(myTrans(mean1),myInv(cov)),mean1)) + log(probc1);
            w21 = myTrans(myMult(myInv(cov),mean3));
            w22 = - (0.5*myMult(myMult(myTrans(mean3),myInv(cov)),mean3)) + log(probc3);
            for i = 1:length(T1)
                x = myTrans(T1(i,:)); 
                x1=g2(x,w11,w12);
                x2=g2(x,w21,w22);
                if(x1>x2)
                    X1=[X1 ;x(1)];
                    Y1=[Y1 ;x(2)];
                else
                    X2=[X2 ;x(1)];
                    Y2=[Y2 ;x(2)];
                end
            end
            for i = 1:length(T3)
                x = myTrans(T3(i,:)); 
                x1=g2(x,w11,w12);
                x2=g2(x,w21,w22);
                if(x1>x2)
                    X1=[X1 ;x(1)];
                    Y1=[Y1 ;x(2)];
                else
                    X2=[X2 ;x(1)];
                    Y2=[Y2 ;x(2)];
                end
            end
            BX1=0;
            BY1=0;
            BX2=0;
            BY2=0;
            row=0;
            for bgx = minX:incX:maxX
                for bgy = minY:incY:maxY
                    x=[bgx;bgy];
                    x1=g2(x,w11,w12);
                    x2=g2(x,w21,w22);
                    if(x1>x2)
                        BX1=[BX1 ;x(1)];
                        BY1=[BY1 ;x(2)];
                    else
                        BX2=[BX2 ;x(1)];
                        BY2=[BY2 ;x(2)];
                    end
                end
            end
            BX1 = BX1(2:length(BX1));
            BX2 = BX2(2:length(BX2));
            BY1 = BY1(2:length(BY1));
            BY2 = BY2(2:length(BY2));
            figure
            plot(BX1,BY1,'.','Color',[1 0.5 0.5 ]),hold on,plot(BX2,BY2,'.','Color',[0.5 1 .5]),plot(X1,Y1,'r.',X2,Y2,'g.'),legend('Class1','Class3'),axis([minX maxX minY maxY]),xlabel('x'),ylabel('y'),title(strcat(name,'-Classes:1&3'));
            
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
                    X1=[X1 ;x(1)];
                    Y1=[Y1 ;x(2)];
                elseif(x2>x1 && x2>x3)
                    confusion(1,2)=confusion(1,2)+1;
                    X2=[X2 ;x(1)];
                    Y2=[Y2 ;x(2)];
                elseif(x3>x1 && x3>x2)
                    confusion(1,3)=confusion(1,3)+1;
                    X3=[X3 ;x(1)];
                    Y3=[Y3 ;x(2)];
                end
            end
            for i = 1:length(T2)
                x = myTrans(T2(i,:)); 
                x1=g2(x,w11,w12);
                x2=g2(x,w21,w22);
                x3=g2(x,w31,w32);
                if(x1>x2 && x1>x3)
                    confusion(2,1)=confusion(2,1)+1;
                    X1=[X1 ;x(1)];
                    Y1=[Y1 ;x(2)];
                elseif(x2>x1 && x2>x3)
                    confusion(2,2)=confusion(2,2)+1;
                    X2=[X2 ;x(1)];
                    Y2=[Y2 ;x(2)];
                elseif(x3>x1 && x3>x2)
                    confusion(2,3)=confusion(2,3)+1;
                    X3=[X3 ;x(1)];
                    Y3=[Y3 ;x(2)];
                end
            end
            for i = 1:length(T3)
                x = myTrans(T3(i,:)); 
                x1=g2(x,w11,w12);
                x2=g2(x,w21,w22);
                x3=g2(x,w31,w32);
                if(x1>x2 && x1>x3)
                    X1=[X1 ;x(1)];
                    Y1=[Y1 ;x(2)];
                    confusion(3,1)=confusion(3,1)+1;
                elseif(x2>x1 && x2>x3)
                    X2=[X2 ;x(1)];
                    Y2=[Y2 ;x(2)];
                    confusion(3,2)=confusion(3,2)+1;
                elseif(x3>x1 && x3>x2)
                    X3=[X3 ;x(1)];
                    Y3=[Y3 ;x(2)];
                    confusion(3,3)=confusion(3,3)+1;
                end
            end
            maxX=max(max(X1),max(X2));
            minX=min(min(X1),min(X2));
            maxY=max(max(Y1),max(Y2));
            minY=min(min(Y1),min(Y2));
            minX=minX-1;
            maxX=maxX+1;
            minY=minY-1;
            maxY=maxY+1;
            incX=(maxX-minX)/150;
            incY=(maxY-minY)/150;
            BX1=0;
            BY1=0;
            BY3=0;
            BX3=0;
            BX2=0;
            BY2=0;
            row=0;
            for bgx = minX:incX:maxX
                row = row+1;
                col=0;
                for bgy = minY:incY:maxY
                    col = col+1;;
                    CX(row,col)=bgx;
                    CY(row,col)=bgy;
                    x=[bgx;bgy];
                    x1=g2(x,w11,w12);
                    x2=g2(x,w21,w22);
                    x3=g2(x,w31,w32);
                    CZ1(row,col)=(x1);
                    CZ2(row,col)=(x2);
                    CZ3(row,col)=(x3);
                    if(x1>x2 && x1>x3)
                        BX1=[BX1 ;x(1)];
                        BY1=[BY1 ;x(2)];
                    elseif(x2>x1 && x2>x3)
                        BX2=[BX2 ;x(1)];
                        BY2=[BY2 ;x(2)];
                    elseif(x3>x1 && x3>x2)
                        BX3=[BX3 ;x(1)];
                        BY3=[BY3 ;x(2)];
                    end
                end
            end
            BX1 = BX1(2:length(BX1));
            BX2 = BX2(2:length(BX2));
            BX3 = BX3(2:length(BX3));
            BY1 = BY1(2:length(BY1));
            BY2 = BY2(2:length(BY2));
            BY3 = BY3(2:length(BY3));
            plot(BX1,BY1,'.','Color',[1 0.5 0.5 ]),hold on,plot(BX2,BY2,'.','Color',[0.5 0.5 1]),plot(BX3,BY3,'.','Color',[0.5 1 .5]),plot(X1,Y1,'r.',X2,Y2,'b.',X3,Y3,'g.'),legend('Class1','Class2','Class3'),axis([minX maxX minY maxY]),xlabel('x'),ylabel('y'),title(strcat(name,'-AllClasses'));
            figure
            contour(CX,CY,CZ1,'r'),hold on,contour(CX,CY,CZ2,'b'),contour(CX,CY,CZ3,'g'),legend('Class1','Class2','Class3'),title(strcat(name,'-Contour')),xlabel('x'),ylabel('y'),hold off

            %A and B
            
            len=len1+len2;
            probc1=len1/len;
            probc2=len2/len;
            cov = (cov1+cov2)/2;
            X1 = D1(:,1);
            Y1 = D1(:,2);
            X2 = D2(:,1);
            Y2 = D2(:,2);
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
                    X1=[X1 ;x(1)];
                    Y1=[Y1 ;x(2)];
                else
                    X2=[X2 ;x(1)];
                    Y2=[Y2 ;x(2)];
                end
            end
            for i = 1:length(T2)
                x = myTrans(T2(i,:)); 
                x1=g2(x,w11,w12);
                x2=g2(x,w21,w22);
                if(x1>x2)
                    X1=[X1 ;x(1)];
                    Y1=[Y1 ;x(2)];
                else
                    X2=[X2 ;x(1)];
                    Y2=[Y2 ;x(2)];
                end
            end
            BX1=0;
            BY1=0;
            BX2=0;
            BY2=0;
            row=0;
            for bgx = minX:incX:maxX
                for bgy = minY:incY:maxY
                    x=[bgx;bgy];
                    x1=g2(x,w11,w12);
                    x2=g2(x,w21,w22);
                    if(x1>x2)
                        BX1=[BX1 ;x(1)];
                        BY1=[BY1 ;x(2)];
                    else
                        BX2=[BX2 ;x(1)];
                        BY2=[BY2 ;x(2)];
                    end
                end
            end
            BX1 = BX1(2:length(BX1));
            BX2 = BX2(2:length(BX2));
            BY1 = BY1(2:length(BY1));
            BY2 = BY2(2:length(BY2));
            figure
            plot(BX1,BY1,'.','Color',[1 0.5 0.5 ]),hold on,plot(BX2,BY2,'.','Color',[0.5 0.5 1]),plot(X1,Y1,'r.',X2,Y2,'b.'),legend('Class1','Class2'),axis([minX maxX minY maxY]),xlabel('x'),ylabel('y'),title(strcat(name,'-Classes:1&2'));
            
            %B & C 
            
            len=len3+len2;
            probc3=len3/len;
            probc2=len2/len;
            cov = (cov3+cov2)/2;
            X1 = D3(:,1);
            Y1 = D3(:,2);
            X2 = D2(:,1);
            Y2 = D2(:,2);
            cov = myCov([D2;D3],myMean([D2;D3]));
            w11 = myTrans(myMult(myInv(cov),mean3));
            w12 = - (0.5*myMult(myMult(myTrans(mean3),myInv(cov)),mean3)) + log(probc3);
            w21 = myTrans(myMult(myInv(cov),mean2));
            w22 = - (0.5*myMult(myMult(myTrans(mean2),myInv(cov)),mean2)) + log(probc2);
            for i = 1:length(T3)
                x = myTrans(T3(i,:)); 
                x1=g2(x,w11,w12);
                x2=g2(x,w21,w22);
                if(x1>x2)
                    X1=[X1 ;x(1)];
                    Y1=[Y1 ;x(2)];
                else
                    X2=[X2 ;x(1)];
                    Y2=[Y2 ;x(2)];
                end
            end
            for i = 1:length(T2)
                x = myTrans(T2(i,:)); 
                x1=g2(x,w11,w12);
                x2=g2(x,w21,w22);
                if(x1>x2)
                    X1=[X1 ;x(1)];
                    Y1=[Y1 ;x(2)];
                else
                    X2=[X2 ;x(1)];
                    Y2=[Y2 ;x(2)];
                end
            end
            BX1=0;
            BY1=0;
            BX2=0;
            BY2=0;
            row=0;
            for bgx = minX:incX:maxX
                for bgy = minY:incY:maxY
                    x=[bgx;bgy];
                    x1=g2(x,w11,w12);
                    x2=g2(x,w21,w22);
                    if(x1>x2)
                        BX1=[BX1 ;x(1)];
                        BY1=[BY1 ;x(2)];
                    else
                        BX2=[BX2 ;x(1)];
                        BY2=[BY2 ;x(2)];
                    end
                end
            end
            BX1 = BX1(2:length(BX1));
            BX2 = BX2(2:length(BX2));
            BY1 = BY1(2:length(BY1));
            BY2 = BY2(2:length(BY2));
            figure
            plot(BX2,BY2,'.','Color',[0.5 0.5 1]),hold on,plot(BX1,BY1,'.','Color',[0.5 1 0.5 ]),plot(X2,Y2,'b.',X1,Y1,'g.'),legend('Class2','Class3'),axis([minX maxX minY maxY]),xlabel('x'),ylabel('y'),title(strcat(name,'-Classes:2&3'));
            
            % A & C
            
            len=len1+len3;
            probc1=len1/len;
            probc3=len3/len;
            cov = (cov1+cov3)/2;
            X1 = D1(:,1);
            Y1 = D1(:,2);
            X2 = D3(:,1);
            Y2 = D3(:,2);
            cov = myCov([D1;D3],myMean([D1;D3]));
            w11 = myTrans(myMult(myInv(cov),mean1));
            w12 = - (0.5*myMult(myMult(myTrans(mean1),myInv(cov)),mean1)) + log(probc1);
            w21 = myTrans(myMult(myInv(cov),mean3));
            w22 = - (0.5*myMult(myMult(myTrans(mean3),myInv(cov)),mean3)) + log(probc3);
            for i = 1:length(T1)
                x = myTrans(T1(i,:)); 
                x1=g2(x,w11,w12);
                x2=g2(x,w21,w22);
                if(x1>x2)
                    X1=[X1 ;x(1)];
                    Y1=[Y1 ;x(2)];
                else
                    X2=[X2 ;x(1)];
                    Y2=[Y2 ;x(2)];
                end
            end
            for i = 1:length(T3)
                x = myTrans(T3(i,:)); 
                x1=g2(x,w11,w12);
                x2=g2(x,w21,w22);
                if(x1>x2)
                    X1=[X1 ;x(1)];
                    Y1=[Y1 ;x(2)];
                else
                    X2=[X2 ;x(1)];
                    Y2=[Y2 ;x(2)];
                end
            end
            BX1=0;
            BY1=0;
            BX2=0;
            BY2=0;
            row=0;
            for bgx = minX:incX:maxX
                for bgy = minY:incY:maxY
                    x=[bgx;bgy];
                    x1=g2(x,w11,w12);
                    x2=g2(x,w21,w22);
                    if(x1>x2)
                        BX1=[BX1 ;x(1)];
                        BY1=[BY1 ;x(2)];
                    else
                        BX2=[BX2 ;x(1)];
                        BY2=[BY2 ;x(2)];
                    end
                end
            end
            BX1 = BX1(2:length(BX1));
            BX2 = BX2(2:length(BX2));
            BY1 = BY1(2:length(BY1));
            BY2 = BY2(2:length(BY2));
            figure
            plot(BX1,BY1,'.','Color',[1 0.5 0.5 ]),hold on,plot(BX2,BY2,'.','Color',[0.5 1 .5]),plot(X1,Y1,'r.',X2,Y2,'g.'),legend('Class1','Class3'),axis([minX maxX minY maxY]),xlabel('x'),ylabel('y'),title(strcat(name,'-Classes:1&3'));
            
        elseif(classifier==3)
            w11 = myTrans(myMult(myInv(cov1),mean1));
            w12 = - (0.5*myMult(myMult(myTrans(mean1),myInv(cov1)),mean1)) + log(probc1) - (0.5*log(abs(myMod(cov1))));
            w21 = myTrans(myMult(myInv(cov2),mean2));
            w22 = - (0.5*myMult(myMult(myTrans(mean2),myInv(cov2)),mean2)) + log(probc2) - (0.5*log(abs(myMod(cov2))));
            w31 = myTrans(myMult(myInv(cov3),mean3));
            w32 = - (0.5*myMult(myMult(myTrans(mean3),myInv(cov3)),mean3)) + log(probc3) - (0.5*log(abs(myMod(cov3))));
            for i = 1:length(T1)
                x = myTrans(T1(i,:)); 
                x1=g3(x,cov1,w11,w12);
                    x2=g3(x,cov2,w21,w22);
                    x3=g3(x,cov3,w31,w32);
                if(x1>x2 && x1>x3)
                    confusion(1,1)=confusion(1,1)+1;
                    X1=[X1 ;x(1)];
                    Y1=[Y1 ;x(2)];
                elseif(x2>x1 && x2>x3)
                    confusion(1,2)=confusion(1,2)+1;
                    X2=[X2 ;x(1)];
                    Y2=[Y2 ;x(2)];
                elseif(x3>x1 && x3>x2)
                    confusion(1,3)=confusion(1,3)+1;
                    X3=[X3 ;x(1)];
                    Y3=[Y3 ;x(2)];
                end
            end
            for i = 1:length(T2)
                x = myTrans(T2(i,:)); 
                x1=g3(x,cov1,w11,w12);
                    x2=g3(x,cov2,w21,w22);
                    x3=g3(x,cov3,w31,w32);
                if(x1>x2 && x1>x3)
                    confusion(2,1)=confusion(2,1)+1;
                    X1=[X1 ;x(1)];
                    Y1=[Y1 ;x(2)];
                elseif(x2>x1 && x2>x3)
                    confusion(2,2)=confusion(2,2)+1;
                    X2=[X2 ;x(1)];
                    Y2=[Y2 ;x(2)];
                elseif(x3>x1 && x3>x2)
                    confusion(2,3)=confusion(2,3)+1;
                    X3=[X3 ;x(1)];
                    Y3=[Y3 ;x(2)];
                end
            end
            for i = 1:length(T3)
                x = myTrans(T3(i,:)); 
                x1=g3(x,cov1,w11,w12);
                    x2=g3(x,cov2,w21,w22);
                    x3=g3(x,cov3,w31,w32);
                if(x1>x2 && x1>x3)
                    X1=[X1 ;x(1)];
                    Y1=[Y1 ;x(2)];
                    confusion(3,1)=confusion(3,1)+1;
                elseif(x2>x1 && x2>x3)
                    X2=[X2 ;x(1)];
                    Y2=[Y2 ;x(2)];
                    confusion(3,2)=confusion(3,2)+1;
                elseif(x3>x1 && x3>x2)
                    X3=[X3 ;x(1)];
                    Y3=[Y3 ;x(2)];
                    confusion(3,3)=confusion(3,3)+1;
                end
            end
            maxX=max(max(X1),max(X2));
            minX=min(min(X1),min(X2));
            maxY=max(max(Y1),max(Y2));
            minY=min(min(Y1),min(Y2));
            minX=minX-1;
            maxX=maxX+1;
            minY=minY-1;
            maxY=maxY+1;
            incX=(maxX-minX)/150;
            incY=(maxY-minY)/150;
            BX1=0;
            BY1=0;
            BY3=0;
            BX3=0;
            BX2=0;
            BY2=0;
            row=0;
            for bgx = minX:incX:maxX
                row = row+1;
                col=0;
                for bgy = minY:incY:maxY
                    col = col+1;;
                    CX(row,col)=bgx;
                    CY(row,col)=bgy;
                    x=[bgx;bgy];
                    x1=g3(x,cov1,w11,w12);
                    x2=g3(x,cov2,w21,w22);
                    x3=g3(x,cov3,w31,w32);
                    CZ1(row,col)=(x1);
                    CZ2(row,col)=(x2);
                    CZ3(row,col)=(x3);
                    if(x1>x2 && x1>x3)
                        BX1=[BX1 ;x(1)];
                        BY1=[BY1 ;x(2)];
                    elseif(x2>x1 && x2>x3)
                        BX2=[BX2 ;x(1)];
                        BY2=[BY2 ;x(2)];
                    elseif(x3>x1 && x3>x2)
                        BX3=[BX3 ;x(1)];
                        BY3=[BY3 ;x(2)];
                    end
                end
            end
            BX1 = BX1(2:length(BX1));
            BX2 = BX2(2:length(BX2));
            BX3 = BX3(2:length(BX3));
            BY1 = BY1(2:length(BY1));
            BY2 = BY2(2:length(BY2));
            BY3 = BY3(2:length(BY3));
            plot(BX1,BY1,'.','Color',[1 0.5 0.5 ]),hold on,plot(BX2,BY2,'.','Color',[0.5 0.5 1]),plot(BX3,BY3,'.','Color',[0.5 1 .5]),plot(X1,Y1,'r.',X2,Y2,'b.',X3,Y3,'g.'),legend('Class1','Class2','Class3'),axis([minX maxX minY maxY]),xlabel('x'),ylabel('y'),title(strcat(name,'-AllClasses'));
            figure
            contour(CX,CY,CZ1,'r'),hold on,contour(CX,CY,CZ2,'b'),contour(CX,CY,CZ3,'g'),legend('Class1','Class2','Class3'),title(strcat(name,'-Contour')),xlabel('x'),ylabel('y'),hold off
            %A and B
            
            len=len1+len2;
            probc1=len1/len;
            probc2=len2/len;
            cov = (cov1+cov2)/2;
            X1 = D1(:,1);
            Y1 = D1(:,2);
            X2 = D2(:,1);
            Y2 = D2(:,2);
            w11 = myTrans(myMult(myInv(cov1),mean1));
            w12 = - (0.5*myMult(myMult(myTrans(mean1),myInv(cov1)),mean1)) + log(probc1) - (0.5*log(abs(myMod(cov1))));
            w21 = myTrans(myMult(myInv(cov2),mean2));
            w22 = - (0.5*myMult(myMult(myTrans(mean2),myInv(cov2)),mean2)) + log(probc2) - (0.5*log(abs(myMod(cov2))));
            for i = 1:length(T1)
                x = myTrans(T1(i,:)); 
                x1=g3(x,cov1,w11,w12);
                x2=g3(x,cov2,w21,w22);
                if(x1>x2)
                    X1=[X1 ;x(1)];
                    Y1=[Y1 ;x(2)];
                else
                    X2=[X2 ;x(1)];
                    Y2=[Y2 ;x(2)];
                end
            end
            for i = 1:length(T2)
                x = myTrans(T2(i,:)); 
                x1=g3(x,cov1,w11,w12);
                x2=g3(x,cov2,w21,w22);
                if(x1>x2)
                    X1=[X1 ;x(1)];
                    Y1=[Y1 ;x(2)];
                else
                    X2=[X2 ;x(1)];
                    Y2=[Y2 ;x(2)];
                end
            end
            BX1=0;
            BY1=0;
            BX2=0;
            BY2=0;
            row=0;
            for bgx = minX:incX:maxX
                for bgy = minY:incY:maxY
                    x=[bgx;bgy];
                    x1=g3(x,cov1,w11,w12);
                    x2=g3(x,cov2,w21,w22);
                    if(x1>x2)
                        BX1=[BX1 ;x(1)];
                        BY1=[BY1 ;x(2)];
                    else
                        BX2=[BX2 ;x(1)];
                        BY2=[BY2 ;x(2)];
                    end
                end
            end
            BX1 = BX1(2:length(BX1));
            BX2 = BX2(2:length(BX2));
            BY1 = BY1(2:length(BY1));
            BY2 = BY2(2:length(BY2));
            figure
            plot(BX1,BY1,'.','Color',[1 0.5 0.5 ]),hold on,plot(BX2,BY2,'.','Color',[0.5 0.5 1]),plot(X1,Y1,'r.',X2,Y2,'b.'),legend('Class1','Class2'),axis([minX maxX minY maxY]),xlabel('x'),ylabel('y'),title(strcat(name,'-Classes:1&2'));
            
            %B & C 
            
            len=len3+len2;
            probc3=len3/len;
            probc2=len2/len;
            cov = (cov3+cov2)/2;
            X1 = D3(:,1);
            Y1 = D3(:,2);
            X2 = D2(:,1);
            Y2 = D2(:,2);
            w11 = myTrans(myMult(myInv(cov3),mean3));
            w12 = - (0.5*myMult(myMult(myTrans(mean3),myInv(cov3)),mean3)) + log(probc3) - (0.5*log(abs(myMod(cov3))));
            w21 = myTrans(myMult(myInv(cov2),mean2));
            w22 = - (0.5*myMult(myMult(myTrans(mean2),myInv(cov2)),mean2)) + log(probc2) - (0.5*log(abs(myMod(cov2))));
            for i = 1:length(T3)
                x = myTrans(T3(i,:)); 
                x1=g3(x,cov3,w11,w12);
                x2=g3(x,cov2,w21,w22);
                if(x1>x2)
                    X1=[X1 ;x(1)];
                    Y1=[Y1 ;x(2)];
                else
                    X2=[X2 ;x(1)];
                    Y2=[Y2 ;x(2)];
                end
            end
            for i = 1:length(T2)
                x = myTrans(T2(i,:)); 
                x1=g3(x,cov3,w11,w12);
                x2=g3(x,cov2,w21,w22);
                if(x1>x2)
                    X1=[X1 ;x(1)];
                    Y1=[Y1 ;x(2)];
                else
                    X2=[X2 ;x(1)];
                    Y2=[Y2 ;x(2)];
                end
            end
            BX1=0;
            BY1=0;
            BX2=0;
            BY2=0;
            row=0;
            for bgx = minX:incX:maxX
                for bgy = minY:incY:maxY
                    x=[bgx;bgy];
                    x1=g3(x,cov3,w11,w12);
                    x2=g3(x,cov2,w21,w22);
                    if(x1>x2)
                        BX1=[BX1 ;x(1)];
                        BY1=[BY1 ;x(2)];
                    else
                        BX2=[BX2 ;x(1)];
                        BY2=[BY2 ;x(2)];
                    end
                end
            end
            BX1 = BX1(2:length(BX1));
            BX2 = BX2(2:length(BX2));
            BY1 = BY1(2:length(BY1));
            BY2 = BY2(2:length(BY2));
            figure
            plot(BX2,BY2,'.','Color',[0.5 0.5 1]),hold on,plot(BX1,BY1,'.','Color',[0.5 1 0.5 ]),plot(X2,Y2,'b.',X1,Y1,'g.'),legend('Class2','Class3'),axis([minX maxX minY maxY]),xlabel('x'),ylabel('y'),title(strcat(name,'-Classes:2&3'));
            
            % A & C
            
            len=len1+len3;
            probc1=len1/len;
            probc3=len3/len;
            cov = (cov1+cov3)/2;
            X1 = D1(:,1);
            Y1 = D1(:,2);
            X2 = D3(:,1);
            Y2 = D3(:,2);
            w11 = myTrans(myMult(myInv(cov1),mean1));
            w12 = - (0.5*myMult(myMult(myTrans(mean1),myInv(cov1)),mean1)) + log(probc1) - (0.5*log(abs(myMod(cov1))));
            w21 = myTrans(myMult(myInv(cov3),mean3));
            w22 = - (0.5*myMult(myMult(myTrans(mean3),myInv(cov3)),mean3)) + log(probc3) - (0.5*log(abs(myMod(cov3))));
            for i = 1:length(T1)
                x = myTrans(T1(i,:)); 
                x1=g3(x,cov1,w11,w12);
                x2=g3(x,cov3,w21,w22);
                if(x1>x2)
                    X1=[X1 ;x(1)];
                    Y1=[Y1 ;x(2)];
                else
                    X2=[X2 ;x(1)];
                    Y2=[Y2 ;x(2)];
                end
            end
            for i = 1:length(T3)
                x = myTrans(T3(i,:)); 
                x1=g3(x,cov1,w11,w12);
                x2=g3(x,cov3,w21,w22);
                if(x1>x2)
                    X1=[X1 ;x(1)];
                    Y1=[Y1 ;x(2)];
                else
                    X2=[X2 ;x(1)];
                    Y2=[Y2 ;x(2)];
                end
            end
            BX1=0;
            BY1=0;
            BX2=0;
            BY2=0;
            row=0;
            for bgx = minX:incX:maxX
                for bgy = minY:incY:maxY
                    x=[bgx;bgy];
                    x1=g3(x,cov1,w11,w12);
                    x2=g3(x,cov3,w21,w22);
                    if(x1>x2)
                        BX1=[BX1 ;x(1)];
                        BY1=[BY1 ;x(2)];
                    else
                        BX2=[BX2 ;x(1)];
                        BY2=[BY2 ;x(2)];
                    end
                end
            end
            BX1 = BX1(2:length(BX1));
            BX2 = BX2(2:length(BX2));
            BY1 = BY1(2:length(BY1));
            BY2 = BY2(2:length(BY2));
            figure
            plot(BX1,BY1,'.','Color',[1 0.5 0.5 ]),hold on,plot(BX2,BY2,'.','Color',[0.5 1 .5]),plot(X1,Y1,'r.',X2,Y2,'g.'),legend('Class1','Class3'),axis([minX maxX minY maxY]),xlabel('x'),ylabel('y'),title(strcat(name,'-Classes:1&3'));
            
            
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
                    X1=[X1 ;x(1)];
                    Y1=[Y1 ;x(2)];
                elseif(x2>x1 && x2>x3)
                    confusion(1,2)=confusion(1,2)+1;
                    X2=[X2 ;x(1)];
                    Y2=[Y2 ;x(2)];
                elseif(x3>x1 && x3>x2)
                    confusion(1,3)=confusion(1,3)+1;
                    X3=[X3 ;x(1)];
                    Y3=[Y3 ;x(2)];
                end
            end
            for i = 1:length(T2)
                x = myTrans(T2(i,:)); 
                x1=g1(x,w11,w12);
                    x2=g1(x,w21,w22);
                    x3=g1(x,w31,w32);
                if(x1>x2 && x1>x3)
                    confusion(2,1)=confusion(2,1)+1;
                    X1=[X1 ;x(1)];
                    Y1=[Y1 ;x(2)];
                elseif(x2>x1 && x2>x3)
                    confusion(2,2)=confusion(2,2)+1;
                    X2=[X2 ;x(1)];
                    Y2=[Y2 ;x(2)];
                elseif(x3>x1 && x3>x2)
                    confusion(2,3)=confusion(2,3)+1;
                    X3=[X3 ;x(1)];
                    Y3=[Y3 ;x(2)];
                end
            end
            for i = 1:length(T3)
                x = myTrans(T3(i,:)); 
                x1=g1(x,w11,w12);
                    x2=g1(x,w21,w22);
                    x3=g1(x,w31,w32);
                if(x1>x2 && x1>x3)
                    X1=[X1 ;x(1)];
                    Y1=[Y1 ;x(2)];
                    confusion(3,1)=confusion(3,1)+1;
                elseif(x2>x1 && x2>x3)
                    X2=[X2 ;x(1)];
                    Y2=[Y2 ;x(2)];
                    confusion(3,2)=confusion(3,2)+1;
                elseif(x3>x1 && x3>x2)
                    X3=[X3 ;x(1)];
                    Y3=[Y3 ;x(2)];
                    confusion(3,3)=confusion(3,3)+1;
                end
            end
            maxX=max(max(X1),max(X2));
            minX=min(min(X1),min(X2));
            maxY=max(max(Y1),max(Y2));
            minY=min(min(Y1),min(Y2));
            minX=minX-1;
            maxX=maxX+1;
            minY=minY-1;
            maxY=maxY+1;
            incX=(maxX-minX)/150;
            incY=(maxY-minY)/150;
            BX1=0;
            BY1=0;
            BY3=0;
            BX3=0;
            BX2=0;
            BY2=0;
            row=0;
            for bgx = minX:incX:maxX
                row = row+1;
                col=0;
                for bgy = minY:incY:maxY
                    col = col+1;;
                    CX(row,col)=bgx;
                    CY(row,col)=bgy;
                    x=[bgx;bgy];
                    x1=g1(x,w11,w12);
                    x2=g1(x,w21,w22);
                    x3=g1(x,w31,w32);
                    CZ1(row,col)=(x1);
                    CZ2(row,col)=(x2);
                    CZ3(row,col)=(x3);
                    if(x1>x2 && x1>x3)
                        BX1=[BX1 ;x(1)];
                        BY1=[BY1 ;x(2)];
                    elseif(x2>x1 && x2>x3)
                        BX2=[BX2 ;x(1)];
                        BY2=[BY2 ;x(2)];
                    elseif(x3>x1 && x3>x2)
                        BX3=[BX3 ;x(1)];
                        BY3=[BY3 ;x(2)];
                    end
                end
            end
            BX1 = BX1(2:length(BX1));
            BX2 = BX2(2:length(BX2));
            BX3 = BX3(2:length(BX3));
            BY1 = BY1(2:length(BY1));
            BY2 = BY2(2:length(BY2));
            BY3 = BY3(2:length(BY3));
            plot(BX1,BY1,'.','Color',[1 0.5 0.5 ]),hold on,plot(BX2,BY2,'.','Color',[0.5 0.5 1]),plot(BX3,BY3,'.','Color',[0.5 1 .5]),plot(X1,Y1,'r.',X2,Y2,'b.',X3,Y3,'g.'),legend('Class1','Class2','Class3'),axis([minX maxX minY maxY]),xlabel('x'),ylabel('y'),title(strcat(name,'-AllClasses'));
            figure
            contour(CX,CY,CZ1,'r'),hold on,contour(CX,CY,CZ2,'b'),contour(CX,CY,CZ3,'g'),legend('Class1','Class2','Class3'),title(strcat(name,'-Contour')),xlabel('x'),ylabel('y'),hold off
            %A and B
            
            len=len1+len2;
            probc1=len1/len;
            probc2=len2/len;
            cov = (cov1+cov2)/2;
            X1 = D1(:,1);
            Y1 = D1(:,2);
            X2 = D2(:,1);
            Y2 = D2(:,2);
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
                    X1=[X1 ;x(1)];
                    Y1=[Y1 ;x(2)];
                else
                    X2=[X2 ;x(1)];
                    Y2=[Y2 ;x(2)];
                end
            end
            for i = 1:length(T2)
                x = myTrans(T2(i,:)); 
                    x1=g1(x,w11,w12);
                    x2=g1(x,w21,w22);
                if(x1>x2)
                    X1=[X1 ;x(1)];
                    Y1=[Y1 ;x(2)];
                else
                    X2=[X2 ;x(1)];
                    Y2=[Y2 ;x(2)];
                end
            end
            BX1=0;
            BY1=0;
            BX2=0;
            BY2=0;
            row=0;
            for bgx = minX:incX:maxX
                for bgy = minY:incY:maxY
                    x=[bgx;bgy];
                    x1=g1(x,w11,w12);
                    x2=g1(x,w21,w22);
                    if(x1>x2)
                        BX1=[BX1 ;x(1)];
                        BY1=[BY1 ;x(2)];
                    else
                        BX2=[BX2 ;x(1)];
                        BY2=[BY2 ;x(2)];
                    end
                end
            end
            BX1 = BX1(2:length(BX1));
            BX2 = BX2(2:length(BX2));
            BY1 = BY1(2:length(BY1));
            BY2 = BY2(2:length(BY2));
            figure
            plot(BX1,BY1,'.','Color',[1 0.5 0.5 ]),hold on,plot(BX2,BY2,'.','Color',[0.5 0.5 1]),plot(X1,Y1,'r.',X2,Y2,'b.'),legend('Class1','Class2'),axis([minX maxX minY maxY]),xlabel('x'),ylabel('y'),title(strcat(name,'-Classes:1&2'));
            
            %B & C 
            
            len=len3+len2;
            probc3=len3/len;
            probc2=len2/len;
            cov = (cov3+cov2)/2;
            X1 = D3(:,1);
            Y1 = D3(:,2);
            X2 = D2(:,1);
            Y2 = D2(:,2);
            cov = diag(diag(cov));
            sigma=(cov(1,1)+cov(2,2))/2;
            cov(1,1)=sigma;
            cov(2,2)=sigma;
            w11 = myTrans(mean3)/sigma;
            w12 = (myMult(myTrans(mean3),mean3)/(((-2)*sigma*sigma))) + log(probc3) ;
            w21 = myTrans(mean2)/sigma;
            w22 = (myMult(myTrans(mean2),mean2)/(((-2)*sigma*sigma))) + log(probc2) ;
            for i = 1:length(T3)
                x = myTrans(T3(i,:)); 
                    x1=g1(x,w11,w12);
                    x2=g1(x,w21,w22);
                if(x1>x2)
                    X1=[X1 ;x(1)];
                    Y1=[Y1 ;x(2)];
                else
                    X2=[X2 ;x(1)];
                    Y2=[Y2 ;x(2)];
                end
            end
            for i = 1:length(T2)
                x = myTrans(T2(i,:)); 
                    x1=g1(x,w11,w12);
                    x2=g1(x,w21,w22);
                if(x1>x2)
                    X1=[X1 ;x(1)];
                    Y1=[Y1 ;x(2)];
                else
                    X2=[X2 ;x(1)];
                    Y2=[Y2 ;x(2)];
                end
            end
            BX1=0;
            BY1=0;
            BX2=0;
            BY2=0;
            row=0;
            for bgx = minX:incX:maxX
                for bgy = minY:incY:maxY
                    x=[bgx;bgy];
                    x1=g1(x,w11,w12);
                    x2=g1(x,w21,w22);
                    if(x1>x2)
                        BX1=[BX1 ;x(1)];
                        BY1=[BY1 ;x(2)];
                    else
                        BX2=[BX2 ;x(1)];
                        BY2=[BY2 ;x(2)];
                    end
                end
            end
            BX1 = BX1(2:length(BX1));
            BX2 = BX2(2:length(BX2));
            BY1 = BY1(2:length(BY1));
            BY2 = BY2(2:length(BY2));
            figure
            plot(BX2,BY2,'.','Color',[0.5 0.5 1]),hold on,plot(BX1,BY1,'.','Color',[0.5 1 0.5 ]),plot(X2,Y2,'b.',X1,Y1,'g.'),legend('Class2','Class3'),axis([minX maxX minY maxY]),xlabel('x'),ylabel('y'),title(strcat(name,'-Classes:2&3'));
            
            % A & C
            
            len=len1+len3;
            probc1=len1/len;
            probc3=len3/len;
            cov = (cov1+cov3)/2;
            X1 = D1(:,1);
            Y1 = D1(:,2);
            X2 = D3(:,1);
            Y2 = D3(:,2);
            cov = diag(diag(cov));
            sigma=(cov(1,1)+cov(2,2))/2;
            cov(1,1)=sigma;
            cov(2,2)=sigma;
            w11 = myTrans(mean1)/sigma;
            w12 = (myMult(myTrans(mean1),mean1)/(((-2)*sigma*sigma))) + log(probc1) ;
            w21 = myTrans(mean3)/sigma;
            w22 = (myMult(myTrans(mean3),mean3)/(((-2)*sigma*sigma))) + log(probc3) ;
            for i = 1:length(T1)
                x = myTrans(T1(i,:)); 
                    x1=g1(x,w11,w12);
                    x2=g1(x,w21,w22);
                if(x1>x2)
                    X1=[X1 ;x(1)];
                    Y1=[Y1 ;x(2)];
                else
                    X2=[X2 ;x(1)];
                    Y2=[Y2 ;x(2)];
                end
            end
            for i = 1:length(T3)
                x = myTrans(T3(i,:)); 
                    x1=g1(x,w11,w12);
                    x2=g1(x,w21,w22);
                if(x1>x2)
                    X1=[X1 ;x(1)];
                    Y1=[Y1 ;x(2)];
                else
                    X2=[X2 ;x(1)];
                    Y2=[Y2 ;x(2)];
                end
            end
            BX1=0;
            BY1=0;
            BX2=0;
            BY2=0;
            row=0;
            for bgx = minX:incX:maxX
                for bgy = minY:incY:maxY
                    x=[bgx;bgy];
                    x1=g1(x,w11,w12);
                    x2=g1(x,w21,w22);
                    if(x1>x2)
                        BX1=[BX1 ;x(1)];
                        BY1=[BY1 ;x(2)];
                    else
                        BX2=[BX2 ;x(1)];
                        BY2=[BY2 ;x(2)];
                    end
                end
            end
            BX1 = BX1(2:length(BX1));
            BX2 = BX2(2:length(BX2));
            BY1 = BY1(2:length(BY1));
            BY2 = BY2(2:length(BY2));
            figure
            plot(BX1,BY1,'.','Color',[1 0.5 0.5 ]),hold on,plot(BX2,BY2,'.','Color',[0.5 1 .5]),plot(X1,Y1,'r.',X2,Y2,'g.'),legend('Class1','Class3'),axis([minX maxX minY maxY]),xlabel('x'),ylabel('y'),title(strcat(name,'-Classes:1&3'));
            
            
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
                    X1=[X1 ;x(1)];
                    Y1=[Y1 ;x(2)];
                elseif(x2>x1 && x2>x3)
                    confusion(1,2)=confusion(1,2)+1;
                    X2=[X2 ;x(1)];
                    Y2=[Y2 ;x(2)];
                elseif(x3>x1 && x3>x2)
                    confusion(1,3)=confusion(1,3)+1;
                    X3=[X3 ;x(1)];
                    Y3=[Y3 ;x(2)];
                end
            end
            for i = 1:length(T2)
                x = myTrans(T2(i,:)); 
                x1=g2(x,w11,w12);
                x2=g2(x,w21,w22);
                x3=g2(x,w31,w32);
                if(x1>x2 && x1>x3)
                    confusion(2,1)=confusion(2,1)+1;
                    X1=[X1 ;x(1)];
                    Y1=[Y1 ;x(2)];
                elseif(x2>x1 && x2>x3)
                    confusion(2,2)=confusion(2,2)+1;
                    X2=[X2 ;x(1)];
                    Y2=[Y2 ;x(2)];
                elseif(x3>x1 && x3>x2)
                    confusion(2,3)=confusion(2,3)+1;
                    X3=[X3 ;x(1)];
                    Y3=[Y3 ;x(2)];
                end
            end
            for i = 1:length(T3)
                x = myTrans(T3(i,:)); 
                x1=g2(x,w11,w12);
                    x2=g2(x,w21,w22);
                    x3=g2(x,w31,w32);
                if(x1>x2 && x1>x3)
                    X1=[X1 ;x(1)];
                    Y1=[Y1 ;x(2)];
                    confusion(3,1)=confusion(3,1)+1;
                elseif(x2>x1 && x2>x3)
                    X2=[X2 ;x(1)];
                    Y2=[Y2 ;x(2)];
                    confusion(3,2)=confusion(3,2)+1;
                elseif(x3>x1 && x3>x2)
                    X3=[X3 ;x(1)];
                    Y3=[Y3 ;x(2)];
                    confusion(3,3)=confusion(3,3)+1;
                end
            end
            maxX=max(max(X1),max(X2));
            minX=min(min(X1),min(X2));
            maxY=max(max(Y1),max(Y2));
            minY=min(min(Y1),min(Y2));
            minX=minX-1;
            maxX=maxX+1;
            minY=minY-1;
            maxY=maxY+1;
            incX=(maxX-minX)/150;
            incY=(maxY-minY)/150;
            BX1=0;
            BY1=0;
            BY3=0;
            BX3=0;
            BX2=0;
            BY2=0;
            row=0;
            for bgx = minX:incX:maxX
                row = row+1;
                col=0;
                for bgy = minY:incY:maxY
                    col = col+1;;
                    CX(row,col)=bgx;
                    CY(row,col)=bgy;
                    x=[bgx;bgy];
                    x1=g2(x,w11,w12);
                    x2=g2(x,w21,w22);
                    x3=g2(x,w31,w32);
                    CZ1(row,col)=(x1);
                    CZ2(row,col)=(x2);
                    CZ3(row,col)=(x3);
                    if(x1>x2 && x1>x3)
                        BX1=[BX1 ;x(1)];
                        BY1=[BY1 ;x(2)];
                    elseif(x2>x1 && x2>x3)
                        BX2=[BX2 ;x(1)];
                        BY2=[BY2 ;x(2)];
                    elseif(x3>x1 && x3>x2)
                        BX3=[BX3 ;x(1)];
                        BY3=[BY3 ;x(2)];
                    end
                end
            end
            BX1 = BX1(2:length(BX1));
            BX2 = BX2(2:length(BX2));
            BX3 = BX3(2:length(BX3));
            BY1 = BY1(2:length(BY1));
            BY2 = BY2(2:length(BY2));
            BY3 = BY3(2:length(BY3));
            plot(BX1,BY1,'.','Color',[1 0.5 0.5 ]),hold on,plot(BX2,BY2,'.','Color',[0.5 0.5 1]),plot(BX3,BY3,'.','Color',[0.5 1 .5]),plot(X1,Y1,'r.',X2,Y2,'b.',X3,Y3,'g.'),legend('Class1','Class2','Class3'),axis([minX maxX minY maxY]),xlabel('x'),ylabel('y'),title(strcat(name,'-AllClasses'));
            figure
            contour(CX,CY,CZ1,'r'),hold on,contour(CX,CY,CZ2,'b'),contour(CX,CY,CZ3,'g'),legend('Class1','Class2','Class3'),title(strcat(name,'-Contour')),xlabel('x'),ylabel('y'),hold off
            %A and B
            
            len=len1+len2;
            probc1=len1/len;
            probc2=len2/len;
            cov = (cov1+cov2)/2;
            X1 = D1(:,1);
            Y1 = D1(:,2);
            X2 = D2(:,1);
            Y2 = D2(:,2);
            cov=diag(diag(cov));
            w11 = myTrans(myMult(myInv(cov),mean1));
            w12 = - (0.5*myMult(myMult(myTrans(mean1),myInv(cov)),mean1)) + log(probc1);
            w21 = myTrans(myMult(myInv(cov),mean2));
            w22 = - (0.5*myMult(myMult(myTrans(mean2),myInv(cov)),mean2)) + log(probc2);
            for i = 1:length(T1)
                x = myTrans(T1(i,:)); 
                x1=g2(x,w11,w12);
                x2=g2(x,w21,w22);
                if(x1>x2)
                    X1=[X1 ;x(1)];
                    Y1=[Y1 ;x(2)];
                else
                    X2=[X2 ;x(1)];
                    Y2=[Y2 ;x(2)];
                end
            end
            for i = 1:length(T2)
                x = myTrans(T2(i,:)); 
                x1=g2(x,w11,w12);
                x2=g2(x,w21,w22);
                if(x1>x2)
                    X1=[X1 ;x(1)];
                    Y1=[Y1 ;x(2)];
                else
                    X2=[X2 ;x(1)];
                    Y2=[Y2 ;x(2)];
                end
            end
            BX1=0;
            BY1=0;
            BX2=0;
            BY2=0;
            row=0;
            for bgx = minX:incX:maxX
                for bgy = minY:incY:maxY
                    x=[bgx;bgy];
                    x1=g2(x,w11,w12);
                    x2=g2(x,w21,w22);
                    if(x1>x2)
                        BX1=[BX1 ;x(1)];
                        BY1=[BY1 ;x(2)];
                    else
                        BX2=[BX2 ;x(1)];
                        BY2=[BY2 ;x(2)];
                    end
                end
            end
            BX1 = BX1(2:length(BX1));
            BX2 = BX2(2:length(BX2));
            BY1 = BY1(2:length(BY1));
            BY2 = BY2(2:length(BY2));
            figure
            plot(BX1,BY1,'.','Color',[1 0.5 0.5 ]),hold on,plot(BX2,BY2,'.','Color',[0.5 0.5 1]),plot(X1,Y1,'r.',X2,Y2,'b.'),legend('Class1','Class2'),axis([minX maxX minY maxY]),xlabel('x'),ylabel('y'),title(strcat(name,'-Classes:1&2'));
            
            %B & C 
            
            len=len3+len2;
            probc3=len3/len;
            probc2=len2/len;
            cov = (cov3+cov2)/2;
            X1 = D3(:,1);
            Y1 = D3(:,2);
            X2 = D2(:,1);
            Y2 = D2(:,2);
            cov=diag(diag(cov));
            w11 = myTrans(myMult(myInv(cov),mean3));
            w12 = - (0.5*myMult(myMult(myTrans(mean3),myInv(cov)),mean3)) + log(probc3);
            w21 = myTrans(myMult(myInv(cov),mean2));
            w22 = - (0.5*myMult(myMult(myTrans(mean2),myInv(cov)),mean2)) + log(probc2);
            for i = 1:length(T3)
                x = myTrans(T3(i,:)); 
                x1=g2(x,w11,w12);
                x2=g2(x,w21,w22);
                if(x1>x2)
                    X1=[X1 ;x(1)];
                    Y1=[Y1 ;x(2)];
                else
                    X2=[X2 ;x(1)];
                    Y2=[Y2 ;x(2)];
                end
            end
            for i = 1:length(T2)
                x = myTrans(T2(i,:)); 
                x1=g2(x,w11,w12);
                x2=g2(x,w21,w22);
                if(x1>x2)
                    X1=[X1 ;x(1)];
                    Y1=[Y1 ;x(2)];
                else
                    X2=[X2 ;x(1)];
                    Y2=[Y2 ;x(2)];
                end
            end
            BX1=0;
            BY1=0;
            BX2=0;
            BY2=0;
            row=0;
            for bgx = minX:incX:maxX
                for bgy = minY:incY:maxY
                    x=[bgx;bgy];
                    x1=g2(x,w11,w12);
                    x2=g2(x,w21,w22);
                    if(x1>x2)
                        BX1=[BX1 ;x(1)];
                        BY1=[BY1 ;x(2)];
                    else
                        BX2=[BX2 ;x(1)];
                        BY2=[BY2 ;x(2)];
                    end
                end
            end
            BX1 = BX1(2:length(BX1));
            BX2 = BX2(2:length(BX2));
            BY1 = BY1(2:length(BY1));
            BY2 = BY2(2:length(BY2));
            figure
            plot(BX2,BY2,'.','Color',[0.5 0.5 1]),hold on,plot(BX1,BY1,'.','Color',[0.5 1 0.5 ]),plot(X2,Y2,'b.',X1,Y1,'g.'),legend('Class2','Class3'),axis([minX maxX minY maxY]),xlabel('x'),ylabel('y'),title(strcat(name,'-Classes:2&3'));
            
            % A & C
            
            len=len1+len3;
            probc1=len1/len;
            probc3=len3/len;
            cov = (cov1+cov3)/2;
            X1 = D1(:,1);
            Y1 = D1(:,2);
            X2 = D3(:,1);
            Y2 = D3(:,2);
            cov=diag(diag(cov));
            w11 = myTrans(myMult(myInv(cov),mean1));
            w12 = - (0.5*myMult(myMult(myTrans(mean1),myInv(cov)),mean1)) + log(probc1);
            w21 = myTrans(myMult(myInv(cov),mean3));
            w22 = - (0.5*myMult(myMult(myTrans(mean3),myInv(cov)),mean3)) + log(probc3);
            for i = 1:length(T1)
                x = myTrans(T1(i,:)); 
                x1=g2(x,w11,w12);
                x2=g2(x,w21,w22);
                if(x1>x2)
                    X1=[X1 ;x(1)];
                    Y1=[Y1 ;x(2)];
                else
                    X2=[X2 ;x(1)];
                    Y2=[Y2 ;x(2)];
                end
            end
            for i = 1:length(T3)
                x = myTrans(T3(i,:)); 
                x1=g2(x,w11,w12);
                x2=g2(x,w21,w22);
                if(x1>x2)
                    X1=[X1 ;x(1)];
                    Y1=[Y1 ;x(2)];
                else
                    X2=[X2 ;x(1)];
                    Y2=[Y2 ;x(2)];
                end
            end
            BX1=0;
            BY1=0;
            BX2=0;
            BY2=0;
            row=0;
            for bgx = minX:incX:maxX
                for bgy = minY:incY:maxY
                    x=[bgx;bgy];
                    x1=g2(x,w11,w12);
                    x2=g2(x,w21,w22);
                    if(x1>x2)
                        BX1=[BX1 ;x(1)];
                        BY1=[BY1 ;x(2)];
                    else
                        BX2=[BX2 ;x(1)];
                        BY2=[BY2 ;x(2)];
                    end
                end
            end
            BX1 = BX1(2:length(BX1));
            BX2 = BX2(2:length(BX2));
            BY1 = BY1(2:length(BY1));
            BY2 = BY2(2:length(BY2));
            figure
            plot(BX1,BY1,'.','Color',[1 0.5 0.5 ]),hold on,plot(BX2,BY2,'.','Color',[0.5 1 .5]),plot(X1,Y1,'r.',X2,Y2,'g.'),legend('Class1','Class3'),axis([minX maxX minY maxY]),xlabel('x'),ylabel('y'),title(strcat(name,'-Classes:1&3'));
            
            
        elseif(classifier==6)
            cov1=diag(diag(cov1));
            cov2=diag(diag(cov2));
            cov3=diag(diag(cov3));
            w11 = myTrans(myMult(myInv(cov1),mean1));
            w12 = - (0.5*myMult(myMult(myTrans(mean1),myInv(cov1)),mean1)) + log(probc1) - (0.5*log(abs(myMod(cov1))));
            w21 = myTrans(myMult(myInv(cov2),mean2));
            w22 = - (0.5*myMult(myMult(myTrans(mean2),myInv(cov2)),mean2)) + log(probc2) - (0.5*log(abs(myMod(cov2))));
            w31 = myTrans(myMult(myInv(cov3),mean3));
            w32 = - (0.5*myMult(myMult(myTrans(mean3),myInv(cov3)),mean3)) + log(probc3) - (0.5*log(abs(myMod(cov3))));
            for i = 1:length(T1)
                x = myTrans(T1(i,:)); 
                x1=g3(x,cov1,w11,w12);
                    x2=g3(x,cov2,w21,w22);
                    x3=g3(x,cov3,w31,w32);
                if(x1>x2 && x1>x3)
                    confusion(1,1)=confusion(1,1)+1;
                    X1=[X1 ;x(1)];
                    Y1=[Y1 ;x(2)];
                elseif(x2>x1 && x2>x3)
                    confusion(1,2)=confusion(1,2)+1;
                    X2=[X2 ;x(1)];
                    Y2=[Y2 ;x(2)];
                elseif(x3>x1 && x3>x2)
                    confusion(1,3)=confusion(1,3)+1;
                    X3=[X3 ;x(1)];
                    Y3=[Y3 ;x(2)];
                end
            end
            for i = 1:length(T2)
                x = myTrans(T2(i,:)); 
                x1=g3(x,cov1,w11,w12);
                    x2=g3(x,cov2,w21,w22);
                    x3=g3(x,cov3,w31,w32);
                if(x1>x2 && x1>x3)
                    confusion(2,1)=confusion(2,1)+1;
                    X1=[X1 ;x(1)];
                    Y1=[Y1 ;x(2)];
                elseif(x2>x1 && x2>x3)
                    confusion(2,2)=confusion(2,2)+1;
                    X2=[X2 ;x(1)];
                    Y2=[Y2 ;x(2)];
                elseif(x3>x1 && x3>x2)
                    confusion(2,3)=confusion(2,3)+1;
                    X3=[X3 ;x(1)];
                    Y3=[Y3 ;x(2)];
                end
            end
            for i = 1:length(T3)
                x = myTrans(T3(i,:)); 
                x1=g3(x,cov1,w11,w12);
                x2=g3(x,cov2,w21,w22);
                x3=g3(x,cov3,w31,w32);
                if(x1>x2 && x1>x3)
                    X1=[X1 ;x(1)];
                    Y1=[Y1 ;x(2)];
                    confusion(3,1)=confusion(3,1)+1;
                elseif(x2>x1 && x2>x3)
                    X2=[X2 ;x(1)];
                    Y2=[Y2 ;x(2)];
                    confusion(3,2)=confusion(3,2)+1;
                elseif(x3>x1 && x3>x2)
                    X3=[X3 ;x(1)];
                    Y3=[Y3 ;x(2)];
                    confusion(3,3)=confusion(3,3)+1;
                end
            end
            maxX=max(max(X1),max(X2));
            minX=min(min(X1),min(X2));
            maxY=max(max(Y1),max(Y2));
            minY=min(min(Y1),min(Y2));
            minX=minX-1;
            maxX=maxX+1;
            minY=minY-1;
            maxY=maxY+1;
            incX=(maxX-minX)/150;
            incY=(maxY-minY)/150;
            BX1=0;
            BY1=0;
            BY3=0;
            BX3=0;
            BX2=0;
            BY2=0;
            row=0;
            for bgx = minX:incX:maxX
                row = row+1;
                col=0;
                for bgy = minY:incY:maxY
                    col = col+1;;
                    CX(row,col)=bgx;
                    CY(row,col)=bgy;
                    x=[bgx;bgy];
                    x1=g3(x,cov1,w11,w12);
                    x2=g3(x,cov2,w21,w22);
                    x3=g3(x,cov3,w31,w32);
                    CZ1(row,col)=(x1);
                    CZ2(row,col)=(x2);
                    CZ3(row,col)=(x3);
                    if(x1>x2 && x1>x3)
                        BX1=[BX1 ;x(1)];
                        BY1=[BY1 ;x(2)];
                    elseif(x2>x1 && x2>x3)
                        BX2=[BX2 ;x(1)];
                        BY2=[BY2 ;x(2)];
                    elseif(x3>x1 && x3>x2)
                        BX3=[BX3 ;x(1)];
                        BY3=[BY3 ;x(2)];
                    end
                end
            end
            BX1 = BX1(2:length(BX1));
            BX2 = BX2(2:length(BX2));
            BX3 = BX3(2:length(BX3));
            BY1 = BY1(2:length(BY1));
            BY2 = BY2(2:length(BY2));
            BY3 = BY3(2:length(BY3));
            plot(BX1,BY1,'.','Color',[1 0.5 0.5 ]),hold on,plot(BX2,BY2,'.','Color',[0.5 0.5 1]),plot(BX3,BY3,'.','Color',[0.5 1 .5]),plot(X1,Y1,'r.',X2,Y2,'b.',X3,Y3,'g.'),legend('Class1','Class2','Class3'),axis([minX maxX minY maxY]),xlabel('x'),ylabel('y'),title(strcat(name,'-AllClasses'));
            figure
            contour(CX,CY,CZ1,'r'),hold on,contour(CX,CY,CZ2,'b'),contour(CX,CY,CZ3,'g'),legend('Class1','Class2','Class3'),title(strcat(name,'-Contour')),xlabel('x'),ylabel('y'),hold off
            %A and B
            
            len=len1+len2;
            probc1=len1/len;
            probc2=len2/len;
            cov = (cov1+cov2)/2;
            X1 = D1(:,1);
            Y1 = D1(:,2);
            X2 = D2(:,1);
            Y2 = D2(:,2);
            cov1=diag(diag(cov1));
            cov2=diag(diag(cov2));
            w11 = myTrans(myMult(myInv(cov1),mean1));
            w12 = - (0.5*myMult(myMult(myTrans(mean1),myInv(cov1)),mean1)) + log(probc1) - (0.5*log(abs(myMod(cov1))));
            w21 = myTrans(myMult(myInv(cov2),mean2));
            w22 = - (0.5*myMult(myMult(myTrans(mean2),myInv(cov2)),mean2)) + log(probc2) - (0.5*log(abs(myMod(cov2))));
            for i = 1:length(T1)
                x = myTrans(T1(i,:)); 
                x1=g3(x,cov1,w11,w12);
                x2=g3(x,cov2,w21,w22);
                if(x1>x2)
                    X1=[X1 ;x(1)];
                    Y1=[Y1 ;x(2)];
                else
                    X2=[X2 ;x(1)];
                    Y2=[Y2 ;x(2)];
                end
            end
            for i = 1:length(T2)
                x = myTrans(T2(i,:)); 
                x1=g3(x,cov1,w11,w12);
                x2=g3(x,cov2,w21,w22);
                if(x1>x2)
                    X1=[X1 ;x(1)];
                    Y1=[Y1 ;x(2)];
                else
                    X2=[X2 ;x(1)];
                    Y2=[Y2 ;x(2)];
                end
            end
            BX1=0;
            BY1=0;
            BX2=0;
            BY2=0;
            row=0;
            for bgx = minX:incX:maxX
                for bgy = minY:incY:maxY
                    x=[bgx;bgy];
                x1=g3(x,cov1,w11,w12);
                x2=g3(x,cov2,w21,w22);
                    if(x1>x2)
                        BX1=[BX1 ;x(1)];
                        BY1=[BY1 ;x(2)];
                    else
                        BX2=[BX2 ;x(1)];
                        BY2=[BY2 ;x(2)];
                    end
                end
            end
            BX1 = BX1(2:length(BX1));
            BX2 = BX2(2:length(BX2));
            BY1 = BY1(2:length(BY1));
            BY2 = BY2(2:length(BY2));
            figure
            plot(BX1,BY1,'.','Color',[1 0.5 0.5 ]),hold on,plot(BX2,BY2,'.','Color',[0.5 0.5 1]),plot(X1,Y1,'r.',X2,Y2,'b.'),legend('Class1','Class2'),axis([minX maxX minY maxY]),xlabel('x'),ylabel('y'),title(strcat(name,'-Classes:1&2'));
            
            %B & C 
            
            len=len3+len2;
            probc3=len3/len;
            probc2=len2/len;
            cov = (cov3+cov2)/2;
            X1 = D3(:,1);
            Y1 = D3(:,2);
            X2 = D2(:,1);
            Y2 = D2(:,2);
            cov3=diag(diag(cov3));
            cov2=diag(diag(cov2));
            w11 = myTrans(myMult(myInv(cov3),mean3));
            w12 = - (0.5*myMult(myMult(myTrans(mean3),myInv(cov3)),mean3)) + log(probc3) - (0.5*log(abs(myMod(cov3))));
            w21 = myTrans(myMult(myInv(cov2),mean2));
            w22 = - (0.5*myMult(myMult(myTrans(mean2),myInv(cov2)),mean2)) + log(probc2) - (0.5*log(abs(myMod(cov2))));
            for i = 1:length(T3)
                x = myTrans(T3(i,:)); 
                x1=g3(x,cov3,w11,w12);
                x2=g3(x,cov2,w21,w22);
                if(x1>x2)
                    X1=[X1 ;x(1)];
                    Y1=[Y1 ;x(2)];
                else
                    X2=[X2 ;x(1)];
                    Y2=[Y2 ;x(2)];
                end
            end
            for i = 1:length(T2)
                x = myTrans(T2(i,:)); 
                x1=g3(x,cov3,w11,w12);
                x2=g3(x,cov2,w21,w22);
                if(x1>x2)
                    X1=[X1 ;x(1)];
                    Y1=[Y1 ;x(2)];
                else
                    X2=[X2 ;x(1)];
                    Y2=[Y2 ;x(2)];
                end
            end
            BX1=0;
            BY1=0;
            BX2=0;
            BY2=0;
            row=0;
            for bgx = minX:incX:maxX
                for bgy = minY:incY:maxY
                    x=[bgx;bgy];
                x1=g3(x,cov3,w11,w12);
                x2=g3(x,cov2,w21,w22);
                    if(x1>x2)
                        BX1=[BX1 ;x(1)];
                        BY1=[BY1 ;x(2)];
                    else
                        BX2=[BX2 ;x(1)];
                        BY2=[BY2 ;x(2)];
                    end
                end
            end
            BX1 = BX1(2:length(BX1));
            BX2 = BX2(2:length(BX2));
            BY1 = BY1(2:length(BY1));
            BY2 = BY2(2:length(BY2));
            figure
            plot(BX2,BY2,'.','Color',[0.5 0.5 1]),hold on,plot(BX1,BY1,'.','Color',[0.5 1 0.5 ]),plot(X2,Y2,'b.',X1,Y1,'g.'),legend('Class2','Class3'),axis([minX maxX minY maxY]),xlabel('x'),ylabel('y'),title(strcat(name,'-Classes:2&3'));
            
            % A & C
            
            len=len1+len3;
            probc1=len1/len;
            probc3=len3/len;
            cov = (cov1+cov3)/2;
            X1 = D1(:,1);
            Y1 = D1(:,2);
            X2 = D3(:,1);
            Y2 = D3(:,2);
            cov1=diag(diag(cov1));
            cov3=diag(diag(cov3));
            w11 = myTrans(myMult(myInv(cov1),mean1));
            w12 = - (0.5*myMult(myMult(myTrans(mean1),myInv(cov1)),mean1)) + log(probc1) - (0.5*log(abs(myMod(cov1))));
            w21 = myTrans(myMult(myInv(cov3),mean3));
            w22 = - (0.5*myMult(myMult(myTrans(mean3),myInv(cov3)),mean3)) + log(probc3) - (0.5*log(abs(myMod(cov3))));
            for i = 1:length(T1)
                x = myTrans(T1(i,:)); 
                x1=g3(x,cov1,w11,w12);
                x2=g3(x,cov3,w21,w22);
                if(x1>x2)
                    X1=[X1 ;x(1)];
                    Y1=[Y1 ;x(2)];
                else
                    X2=[X2 ;x(1)];
                    Y2=[Y2 ;x(2)];
                end
            end
            for i = 1:length(T3)
                x = myTrans(T3(i,:)); 
                x1=g3(x,cov1,w11,w12);
                x2=g3(x,cov3,w21,w22);
                if(x1>x2)
                    X1=[X1 ;x(1)];
                    Y1=[Y1 ;x(2)];
                else
                    X2=[X2 ;x(1)];
                    Y2=[Y2 ;x(2)];
                end
            end
            BX1=0;
            BY1=0;
            BX2=0;
            BY2=0;
            row=0;
            for bgx = minX:incX:maxX
                for bgy = minY:incY:maxY
                    x=[bgx;bgy];
                x1=g3(x,cov1,w11,w12);
                x2=g3(x,cov3,w21,w22);
                    if(x1>x2)
                        BX1=[BX1 ;x(1)];
                        BY1=[BY1 ;x(2)];
                    else
                        BX2=[BX2 ;x(1)];
                        BY2=[BY2 ;x(2)];
                    end
                end
            end
            BX1 = BX1(2:length(BX1));
            BX2 = BX2(2:length(BX2));
            BY1 = BY1(2:length(BY1));
            BY2 = BY2(2:length(BY2));
            figure
            plot(BX1,BY1,'.','Color',[1 0.5 0.5 ]),hold on,plot(BX2,BY2,'.','Color',[0.5 1 .5]),plot(X1,Y1,'r.',X2,Y2,'g.'),legend('Class1','Class3'),axis([minX maxX minY maxY]),xlabel('x'),ylabel('y'),title(strcat(name,'-Classes:1&3'));

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