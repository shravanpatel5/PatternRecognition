function plotter(folder,numofclasses,classifier,name)
    addpath('C:\Users\jems\Desktop\SEM5\Pattern\Assignment1\PatternRecognition\Assignment1\Functions');
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
        mean1 = Mean(D1);
        mean2 = Mean(D2);
        cov1 = Cov(D1,mean1);
        cov2 = Cov(D2,mean2);
        if(classifier==1)
            cov = (cov1+cov2)/2;
            [BX1 BY1 BX2 BY2 X1 Y1 X2 Y2 minX maxX minY maxY CX CY CZ1 CZ2 confusion]=fun(2,cov,cov,mean1,mean2,probc1,probc2,T1,T2,D1,D2,0,0,0,0,0);      
            plot(BX1,BY1,'.','Color',[1 .5 .5]),hold on,plot(BX2,BY2,'.','Color',[.5 .5 1]),plot(X1,Y1,'r.',X2,Y2,'b.'),axis([minX maxX minY maxY]),xlabel('x'),ylabel('y'),title(strcat(name,'-AllClasses')),legend('Class1','Class2'),set(gca,'Color',[1 1 1]),hold off;
            figure
            contour(CX,CY,max(CZ1,CZ2),35),xlabel('x'),ylabel('y'),title(strcat(name,'-Contour')),hold off
        elseif(classifier==2)
            cov = Cov([D1;D2],Mean([D1;D2]));
            [BX1 BY1 BX2 BY2 X1 Y1 X2 Y2 minX maxX minY maxY CX CY CZ1 CZ2 confusion]=fun(2,cov,cov,mean1,mean2,probc1,probc2,T1,T2,D1,D2,0,0,0,0,0);      
            plot(BX1,BY1,'.','Color',[1 .5 .5]),hold on,plot(BX2,BY2,'.','Color',[.5 .5 1]),plot(X1,Y1,'r.',X2,Y2,'b.'),axis([minX maxX minY maxY]),xlabel('x'),ylabel('y'),title(strcat(name,'-AllClasses')),legend('Class1','Class2'),set(gca,'Color',[1 1 1]),hold off;
            figure
            contour(CX,CY,max(CZ1,CZ2),35),xlabel('x'),ylabel('y'),title(strcat(name,'-Contour')),hold off
        elseif(classifier==3)
            [BX1 BY1 BX2 BY2 X1 Y1 X2 Y2 minX maxX minY maxY CX CY CZ1 CZ2 confusion]=fun(3,cov1,cov2,mean1,mean2,probc1,probc2,T1,T2,D1,D2,0,0,0,0,0);       
            plot(BX1,BY1,'.','Color',[1 .5 .5]),hold on,plot(BX2,BY2,'.','Color',[.5 .5 1]),plot(X1,Y1,'r.',X2,Y2,'b.'),axis([minX maxX minY maxY]),xlabel('x'),ylabel('y'),title(strcat(name,'-AllClasses')),legend('Class1','Class2'),set(gca,'Color',[1 1 1]),hold off;
            figure
            contour(CX,CY,max(CZ1,CZ2),50),xlabel('x'),ylabel('y'),title(strcat(name,'-Contour')),hold off
        elseif(classifier==4)
            cov = (cov1+cov2)/2;
            cov = diag(diag(cov));
            sigma=(cov(1,1)+cov(2,2))/2;
            cov(1,1)=sigma;
            cov(2,2)=sigma;
            [BX1 BY1 BX2 BY2 X1 Y1 X2 Y2 minX maxX minY maxY CX CY CZ1 CZ2 confusion]=fun(1,cov,cov,mean1,mean2,probc1,probc2,T1,T2,D1,D2,0,0,0,0,0);  
            plot(BX1,BY1,'.','Color',[1 .5 .5]),hold on,plot(BX2,BY2,'.','Color',[.5 .5 1]),plot(X1,Y1,'r.',X2,Y2,'b.'),axis([minX maxX minY maxY]),xlabel('x'),ylabel('y'),title(strcat(name,'-AllClasses')),legend('Class1','Class2'),set(gca,'Color',[1 1 1]),hold off;
            figure
            contour(CX,CY,max(CZ1,CZ2),35),xlabel('x'),ylabel('y'),title(strcat(name,'-Contour')),hold off
        elseif(classifier==5)
            cov = (cov1+cov2)/2;
            cov = diag(diag(cov));
            [BX1 BY1 BX2 BY2 X1 Y1 X2 Y2 minX maxX minY maxY CX CY CZ1 CZ2 confusion]=fun(2,cov,cov,mean1,mean2,probc1,probc2,T1,T2,D1,D2,0,0,0,0,0);  
            plot(BX1,BY1,'.','Color',[1 .5 .5]),hold on,plot(BX2,BY2,'.','Color',[.5 .5 1]),plot(X1,Y1,'r.',X2,Y2,'b.'),axis([minX maxX minY maxY]),xlabel('x'),ylabel('y'),title(strcat(name,'-AllClasses')),legend('Class1','Class2'),set(gca,'Color',[1 1 1]),hold off;
            figure
            contour(CX,CY,max(CZ1,CZ2),35),xlabel('x'),ylabel('y'),title(strcat(name,'-Contour')),hold off
        elseif(classifier==6)
            cov1=diag(diag(cov1));
            cov2=diag(diag(cov2));
            [BX1 BY1 BX2 BY2 X1 Y1 X2 Y2 minX maxX minY maxY CX CY CZ1 CZ2 confusion]=fun(3,cov1,cov2,mean1,mean2,probc1,probc2,T1,T2,D1,D2,0,0,0,0,0);       
            plot(BX1,BY1,'.','Color',[1 .5 .5]),hold on,plot(BX2,BY2,'.','Color',[.5 .5 1]),plot(X1,Y1,'r.',X2,Y2,'b.'),axis([minX maxX minY maxY]),xlabel('x'),ylabel('y'),title(strcat(name,'-AllClasses')),legend('Class1','Class2'),set(gca,'Color',[1 1 1]),hold off;
            figure
            contour(CX,CY,max(CZ1,CZ2),50),xlabel('x'),ylabel('y'),title(strcat(name,'-Contour')),hold off
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
        fprintf('\nConfusion Matrix : \n'),disp(confusion);
        fprintf('Classification Accuracy : '),disp(Accuracy);
        fprintf('Precision for Class1 : '),disp(Precision(1));
        fprintf('Precision for Class2 : '),disp(Precision(2));
        fprintf('Mean Precision : '),disp(MeanPrecision);
        fprintf('Recall for Class1 : '),disp(Recall(1));
        fprintf('Recall for Class2 : '),disp(Recall(2));
        fprintf('Mean Recall : '),disp(MeanRecall);
        fprintf('Fmeasure for Class1 : '),disp(Fmeasure(1));
        fprintf('Fmeasure for Class2 : '),disp(Fmeasure(2));
        fprintf('Fmeasure Recall : '),disp(MeanFmeasure);
    else
        len=len1+len2+len3;
        probc1=len1/len;
        probc2=len2/len;
        probc3=len3/len;
        mean1 = Mean(D1);
        mean2 = Mean(D2);
        mean3 = Mean(D3);
        cov1 = Cov(D1,mean1);
        cov2 = Cov(D2,mean2);
        cov3 = Cov(D3,mean3);
        if(classifier==1)
            cov = (cov1+cov2+cov3)/2;
            [BX1 BY1 BX2 BY2 BX3 BY3 X1 Y1 X2 Y2 X3 Y3 minX maxX minY maxY CX CY CZ1 CZ2 CZ3 confusion]=fun2(2,cov,cov,cov,mean1,mean2,mean3,probc1,probc2,probc3,T1,T2,T3,D1,D2,D3);       
            plot(BX1,BY1,'.','Color',[1 0.5 0.5 ]),hold on,plot(BX2,BY2,'.','Color',[0.5 0.5 1]),plot(BX3,BY3,'.','Color',[0.5 1 .5]),plot(X1,Y1,'r.',X2,Y2,'b.',X3,Y3,'g.'),legend('Class1','Class2','Class3'),axis([minX maxX minY maxY]),xlabel('x'),ylabel('y'),title(strcat(name,'-AllClasses'));
            figure
            contour(CX,CY,max(CZ1,max(CZ2,CZ3)),50),title(strcat(name,'-Contour')),xlabel('x'),ylabel('y'),hold off
            
            %A and B
            
            len=len1+len2;
            probc1=len1/len;
            probc2=len2/len;
            cov = (cov1+cov2)/2;
            [BX1 BY1 BX2 BY2 X1 Y1 X2 Y2 minX maxX minY maxY CX CY CZ1 CZ2 confusion1]=fun(2,cov,cov,mean1,mean2,probc1,probc2,T1,T2,D1,D2,1,minX,maxX,minY,maxY);        
            figure
            plot(BX1,BY1,'.','Color',[1 0.5 0.5 ]),hold on,plot(BX2,BY2,'.','Color',[0.5 0.5 1]),plot(X1,Y1,'r.',X2,Y2,'b.'),legend('Class1','Class2'),axis([minX maxX minY maxY]),xlabel('x'),ylabel('y'),title(strcat(name,'-Classes:1&2'));
            
            %B & C 
            
            len=len3+len2;
            probc3=len3/len;
            probc2=len2/len;
            cov = (cov3+cov2)/2;
            [BX1 BY1 BX2 BY2 X1 Y1 X2 Y2 minX maxX minY maxY CX CY CZ1 CZ2 confusion1]=fun(2,cov,cov,mean3,mean2,probc3,probc2,T3,T2,D3,D2,1,minX,maxX,minY,maxY);        
            figure
            plot(BX2,BY2,'.','Color',[0.5 0.5 1]),hold on,plot(BX1,BY1,'.','Color',[0.5 1 0.5 ]),plot(X2,Y2,'b.',X1,Y1,'g.'),legend('Class2','Class3'),axis([minX maxX minY maxY]),xlabel('x'),ylabel('y'),title(strcat(name,'-Classes:2&3'));
            
            % A & C
            
            len=len1+len3;
            probc1=len1/len;
            probc3=len3/len;
            cov = (cov1+cov3)/2;
            [BX1 BY1 BX2 BY2 X1 Y1 X2 Y2 minX maxX minY maxY CX CY CZ1 CZ2 confusion1]=fun(2,cov,cov,mean1,mean3,probc1,probc3,T1,T3,D1,D3,1,minX,maxX,minY,maxY);        
            figure
            plot(BX1,BY1,'.','Color',[1 0.5 0.5 ]),hold on,plot(BX2,BY2,'.','Color',[0.5 1 .5]),plot(X1,Y1,'r.',X2,Y2,'g.'),legend('Class1','Class3'),axis([minX maxX minY maxY]),xlabel('x'),ylabel('y'),title(strcat(name,'-Classes:1&3'));
            
        elseif(classifier==2)
            cov = Cov([D1;D2;D3],Mean([D1;D2;D3]));
            [BX1 BY1 BX2 BY2 BX3 BY3 X1 Y1 X2 Y2 X3 Y3 minX maxX minY maxY CX CY CZ1 CZ2 CZ3 confusion]=fun2(2,cov,cov,cov,mean1,mean2,mean3,probc1,probc2,probc3,T1,T2,T3,D1,D2,D3);       
            plot(BX1,BY1,'.','Color',[1 0.5 0.5 ]),hold on,plot(BX2,BY2,'.','Color',[0.5 0.5 1]),plot(BX3,BY3,'.','Color',[0.5 1 .5]),plot(X1,Y1,'r.',X2,Y2,'b.',X3,Y3,'g.'),legend('Class1','Class2','Class3'),axis([minX maxX minY maxY]),xlabel('x'),ylabel('y'),title(strcat(name,'-AllClasses'));
            figure
            contour(CX,CY,max(CZ1,max(CZ2,CZ3)),50),title(strcat(name,'-Contour')),xlabel('x'),ylabel('y'),hold off

            %A and B
            
            len=len1+len2;
            probc1=len1/len;
            probc2=len2/len;
            cov = Cov([D1;D2],Mean([D1;D2]));
            [BX1 BY1 BX2 BY2 X1 Y1 X2 Y2 minX maxX minY maxY CX CY CZ1 CZ2 confusion1]=fun(2,cov,cov,mean1,mean2,probc1,probc2,T1,T2,D1,D2,1,minX,maxX,minY,maxY);        
            figure
            plot(BX1,BY1,'.','Color',[1 0.5 0.5 ]),hold on,plot(BX2,BY2,'.','Color',[0.5 0.5 1]),plot(X1,Y1,'r.',X2,Y2,'b.'),legend('Class1','Class2'),axis([minX maxX minY maxY]),xlabel('x'),ylabel('y'),title(strcat(name,'-Classes:1&2'));
            
            %B & C 
            
            len=len3+len2;
            probc3=len3/len;
            probc2=len2/len;
            cov = Cov([D2;D3],Mean([D2;D3]));
            [BX1 BY1 BX2 BY2 X1 Y1 X2 Y2 minX maxX minY maxY CX CY CZ1 CZ2 confusion1]=fun(2,cov,cov,mean3,mean2,probc3,probc2,T3,T2,D3,D2,1,minX,maxX,minY,maxY);        
            figure
            plot(BX2,BY2,'.','Color',[0.5 0.5 1]),hold on,plot(BX1,BY1,'.','Color',[0.5 1 0.5 ]),plot(X2,Y2,'b.',X1,Y1,'g.'),legend('Class2','Class3'),axis([minX maxX minY maxY]),xlabel('x'),ylabel('y'),title(strcat(name,'-Classes:2&3'));
            
            % A & C
            
            len=len1+len3;
            probc1=len1/len;
            probc3=len3/len;
            cov = Cov([D1;D3],Mean([D1;D3]));
            [BX1 BY1 BX2 BY2 X1 Y1 X2 Y2 minX maxX minY maxY CX CY CZ1 CZ2 confusion1]=fun(2,cov,cov,mean1,mean3,probc1,probc3,T1,T3,D1,D3,1,minX,maxX,minY,maxY);        
            figure
            plot(BX1,BY1,'.','Color',[1 0.5 0.5 ]),hold on,plot(BX2,BY2,'.','Color',[0.5 1 .5]),plot(X1,Y1,'r.',X2,Y2,'g.'),legend('Class1','Class3'),axis([minX maxX minY maxY]),xlabel('x'),ylabel('y'),title(strcat(name,'-Classes:1&3'));
            
        elseif(classifier==3)
            [BX1 BY1 BX2 BY2 BX3 BY3 X1 Y1 X2 Y2 X3 Y3 minX maxX minY maxY CX CY CZ1 CZ2 CZ3 confusion]=fun2(3,cov1,cov2,cov3,mean1,mean2,mean3,probc1,probc2,probc3,T1,T2,T3,D1,D2,D3);       
            plot(BX1,BY1,'.','Color',[1 0.5 0.5 ]),hold on,plot(BX2,BY2,'.','Color',[0.5 0.5 1]),plot(BX3,BY3,'.','Color',[0.5 1 .5]),plot(X1,Y1,'r.',X2,Y2,'b.',X3,Y3,'g.'),legend('Class1','Class2','Class3'),axis([minX maxX minY maxY]),xlabel('x'),ylabel('y'),title(strcat(name,'-AllClasses'));
            figure
            contour(CX,CY,max(CZ1,max(CZ2,CZ3)),70),title(strcat(name,'-Contour')),xlabel('x'),ylabel('y'),hold off
            
            %A and B
            
            len=len1+len2;
            probc1=len1/len;
            probc2=len2/len;
            [BX1 BY1 BX2 BY2 X1 Y1 X2 Y2 minX maxX minY maxY CX CY CZ1 CZ2 confusion1]=fun(3,cov1,cov2,mean1,mean2,probc1,probc2,T1,T2,D1,D2,1,minX,maxX,minY,maxY);        
            figure
            plot(BX1,BY1,'.','Color',[1 0.5 0.5 ]),hold on,plot(BX2,BY2,'.','Color',[0.5 0.5 1]),plot(X1,Y1,'r.',X2,Y2,'b.'),legend('Class1','Class2'),axis([minX maxX minY maxY]),xlabel('x'),ylabel('y'),title(strcat(name,'-Classes:1&2'));
            
            %B & C 
            
            len=len3+len2;
            probc3=len3/len;
            probc2=len2/len;
            [BX1 BY1 BX2 BY2 X1 Y1 X2 Y2 minX maxX minY maxY CX CY CZ1 CZ2 confusion1]=fun(3,cov3,cov2,mean3,mean2,probc3,probc2,T3,T2,D3,D2,1,minX,maxX,minY,maxY);        
            figure
            plot(BX2,BY2,'.','Color',[0.5 0.5 1]),hold on,plot(BX1,BY1,'.','Color',[0.5 1 0.5 ]),plot(X2,Y2,'b.',X1,Y1,'g.'),legend('Class2','Class3'),axis([minX maxX minY maxY]),xlabel('x'),ylabel('y'),title(strcat(name,'-Classes:2&3'));
            
            % A & C
            
            len=len1+len3;
            probc1=len1/len;
            probc3=len3/len;
            [BX1 BY1 BX2 BY2 X1 Y1 X2 Y2 minX maxX minY maxY CX CY CZ1 CZ2 confusion1]=fun(3,cov1,cov3,mean1,mean3,probc1,probc3,T1,T3,D1,D3,1,minX,maxX,minY,maxY);        
            figure
            plot(BX1,BY1,'.','Color',[1 0.5 0.5 ]),hold on,plot(BX2,BY2,'.','Color',[0.5 1 .5]),plot(X1,Y1,'r.',X2,Y2,'g.'),legend('Class1','Class3'),axis([minX maxX minY maxY]),xlabel('x'),ylabel('y'),title(strcat(name,'-Classes:1&3'));
            
        elseif(classifier==4)
            cov = (cov1+cov2+cov3)/3;
            cov = diag(diag(cov));
            sigma=(cov(1,1)+cov(2,2))/2;
            cov(1,1)=sigma;
            cov(2,2)=sigma;
            [BX1 BY1 BX2 BY2 BX3 BY3 X1 Y1 X2 Y2 X3 Y3 minX maxX minY maxY CX CY CZ1 CZ2 CZ3 confusion]=fun2(1,cov,cov,cov,mean1,mean2,mean3,probc1,probc2,probc3,T1,T2,T3,D1,D2,D3);       
            plot(BX1,BY1,'.','Color',[1 0.5 0.5 ]),hold on,plot(BX2,BY2,'.','Color',[0.5 0.5 1]),plot(BX3,BY3,'.','Color',[0.5 1 .5]),plot(X1,Y1,'r.',X2,Y2,'b.',X3,Y3,'g.'),legend('Class1','Class2','Class3'),axis([minX maxX minY maxY]),xlabel('x'),ylabel('y'),title(strcat(name,'-AllClasses'));
            figure
            contour(CX,CY,max(CZ1,max(CZ2,CZ3)),50),title(strcat(name,'-Contour')),xlabel('x'),ylabel('y'),hold off
            %A and B
            
            len=len1+len2;
            probc1=len1/len;
            probc2=len2/len;
            cov = (cov1+cov2)/2;
            cov = diag(diag(cov));
            sigma=(cov(1,1)+cov(2,2))/2;
            cov(1,1)=sigma;
            cov(2,2)=sigma;
            [BX1 BY1 BX2 BY2 X1 Y1 X2 Y2 minX maxX minY maxY CX CY CZ1 CZ2 confusion1]=fun(1,cov,cov,mean1,mean2,probc1,probc2,T1,T2,D1,D2,1,minX,maxX,minY,maxY);        
            figure
            plot(BX1,BY1,'.','Color',[1 0.5 0.5 ]),hold on,plot(BX2,BY2,'.','Color',[0.5 0.5 1]),plot(X1,Y1,'r.',X2,Y2,'b.'),legend('Class1','Class2'),axis([minX maxX minY maxY]),xlabel('x'),ylabel('y'),title(strcat(name,'-Classes:1&2'));
            
            %B & C 
            
            len=len3+len2;
            probc3=len3/len;
            probc2=len2/len;
            cov = (cov3+cov2)/2;
            cov = diag(diag(cov));
            sigma=(cov(1,1)+cov(2,2))/2;
            cov(1,1)=sigma;
            cov(2,2)=sigma;
            [BX1 BY1 BX2 BY2 X1 Y1 X2 Y2 minX maxX minY maxY CX CY CZ1 CZ2 confusion1]=fun(1,cov,cov,mean3,mean2,probc3,probc2,T3,T2,D3,D2,1,minX,maxX,minY,maxY);        
            figure
            plot(BX2,BY2,'.','Color',[0.5 0.5 1]),hold on,plot(BX1,BY1,'.','Color',[0.5 1 0.5 ]),plot(X2,Y2,'b.',X1,Y1,'g.'),legend('Class2','Class3'),axis([minX maxX minY maxY]),xlabel('x'),ylabel('y'),title(strcat(name,'-Classes:2&3'));
            
            % A & C
            
            len=len1+len3;
            probc1=len1/len;
            probc3=len3/len;
            cov = (cov1+cov3)/2;
            cov = diag(diag(cov));
            sigma=(cov(1,1)+cov(2,2))/2;
            cov(1,1)=sigma;
            cov(2,2)=sigma;
            [BX1 BY1 BX2 BY2 X1 Y1 X2 Y2 minX maxX minY maxY CX CY CZ1 CZ2 confusion1]=fun(1,cov,cov,mean1,mean3,probc1,probc3,T1,T3,D1,D3,1,minX,maxX,minY,maxY);        
            figure
            plot(BX1,BY1,'.','Color',[1 0.5 0.5 ]),hold on,plot(BX2,BY2,'.','Color',[0.5 1 .5]),plot(X1,Y1,'r.',X2,Y2,'g.'),legend('Class1','Class3'),axis([minX maxX minY maxY]),xlabel('x'),ylabel('y'),title(strcat(name,'-Classes:1&3'));
            
            
        elseif(classifier==5)
            cov = (cov1+cov2+cov3)/2;
            cov=diag(diag(cov));
            [BX1 BY1 BX2 BY2 BX3 BY3 X1 Y1 X2 Y2 X3 Y3 minX maxX minY maxY CX CY CZ1 CZ2 CZ3 confusion]=fun2(2,cov,cov,cov,mean1,mean2,mean3,probc1,probc2,probc3,T1,T2,T3,D1,D2,D3);       
            plot(BX1,BY1,'.','Color',[1 0.5 0.5 ]),hold on,plot(BX2,BY2,'.','Color',[0.5 0.5 1]),plot(BX3,BY3,'.','Color',[0.5 1 .5]),plot(X1,Y1,'r.',X2,Y2,'b.',X3,Y3,'g.'),legend('Class1','Class2','Class3'),axis([minX maxX minY maxY]),xlabel('x'),ylabel('y'),title(strcat(name,'-AllClasses'));
            figure
            contour(CX,CY,max(CZ1,max(CZ2,CZ3)),50),title(strcat(name,'-Contour')),xlabel('x'),ylabel('y'),hold off
            %A and B
            
            len=len1+len2;
            probc1=len1/len;
            probc2=len2/len;
            cov = (cov1+cov2)/2;
            cov=diag(diag(cov));
            [BX1 BY1 BX2 BY2 X1 Y1 X2 Y2 minX maxX minY maxY CX CY CZ1 CZ2 confusion1]=fun(2,cov,cov,mean1,mean2,probc1,probc2,T1,T2,D1,D2,1,minX,maxX,minY,maxY);        
            figure
            plot(BX1,BY1,'.','Color',[1 0.5 0.5 ]),hold on,plot(BX2,BY2,'.','Color',[0.5 0.5 1]),plot(X1,Y1,'r.',X2,Y2,'b.'),legend('Class1','Class2'),axis([minX maxX minY maxY]),xlabel('x'),ylabel('y'),title(strcat(name,'-Classes:1&2'));
            
            %B & C 
            
            len=len3+len2;
            probc3=len3/len;
            probc2=len2/len;
            cov = (cov3+cov2)/2;
            cov=diag(diag(cov));
            [BX1 BY1 BX2 BY2 X1 Y1 X2 Y2 minX maxX minY maxY CX CY CZ1 CZ2 confusion1]=fun(2,cov,cov,mean3,mean2,probc3,probc2,T3,T2,D3,D2,1,minX,maxX,minY,maxY);        
            figure
            plot(BX2,BY2,'.','Color',[0.5 0.5 1]),hold on,plot(BX1,BY1,'.','Color',[0.5 1 0.5 ]),plot(X2,Y2,'b.',X1,Y1,'g.'),legend('Class2','Class3'),axis([minX maxX minY maxY]),xlabel('x'),ylabel('y'),title(strcat(name,'-Classes:2&3'));
            
            % A & C
            
            len=len1+len3;
            probc1=len1/len;
            probc3=len3/len;
            cov = (cov1+cov3)/2;
            cov=diag(diag(cov));
            [BX1 BY1 BX2 BY2 X1 Y1 X2 Y2 minX maxX minY maxY CX CY CZ1 CZ2 confusion1]=fun(2,cov,cov,mean1,mean3,probc1,probc3,T1,T3,D1,D3,1,minX,maxX,minY,maxY);        
            figure
            plot(BX1,BY1,'.','Color',[1 0.5 0.5 ]),hold on,plot(BX2,BY2,'.','Color',[0.5 1 .5]),plot(X1,Y1,'r.',X2,Y2,'g.'),legend('Class1','Class3'),axis([minX maxX minY maxY]),xlabel('x'),ylabel('y'),title(strcat(name,'-Classes:1&3'));
            
            
        elseif(classifier==6)
            cov1=diag(diag(cov1));
            cov2=diag(diag(cov2));
            cov3=diag(diag(cov3));
            [BX1 BY1 BX2 BY2 BX3 BY3 X1 Y1 X2 Y2 X3 Y3 minX maxX minY maxY CX CY CZ1 CZ2 CZ3 confusion]=fun2(3,cov1,cov2,cov3,mean1,mean2,mean3,probc1,probc2,probc3,T1,T2,T3,D1,D2,D3);       
            plot(BX1,BY1,'.','Color',[1 0.5 0.5 ]),hold on,plot(BX2,BY2,'.','Color',[0.5 0.5 1]),plot(BX3,BY3,'.','Color',[0.5 1 .5]),plot(X1,Y1,'r.',X2,Y2,'b.',X3,Y3,'g.'),legend('Class1','Class2','Class3'),axis([minX maxX minY maxY]),xlabel('x'),ylabel('y'),title(strcat(name,'-AllClasses'));
            figure
            contour(CX,CY,max(CZ1,max(CZ2,CZ3)),70),title(strcat(name,'-Contour')),xlabel('x'),ylabel('y'),hold off
            %A and B
            
            len=len1+len2;
            probc1=len1/len;
            probc2=len2/len;
            cov1=diag(diag(cov1));
            cov2=diag(diag(cov2));
            [BX1 BY1 BX2 BY2 X1 Y1 X2 Y2 minX maxX minY maxY CX CY CZ1 CZ2 confusion1]=fun(3,cov1,cov2,mean1,mean2,probc1,probc2,T1,T2,D1,D2,1,minX,maxX,minY,maxY);        
            figure
            plot(BX1,BY1,'.','Color',[1 0.5 0.5 ]),hold on,plot(BX2,BY2,'.','Color',[0.5 0.5 1]),plot(X1,Y1,'r.',X2,Y2,'b.'),legend('Class1','Class2'),axis([minX maxX minY maxY]),xlabel('x'),ylabel('y'),title(strcat(name,'-Classes:1&2'));
            
            %B & C 
            
            len=len3+len2;
            probc3=len3/len;
            probc2=len2/len;
            cov3=diag(diag(cov3));
            cov2=diag(diag(cov2));
            [BX1 BY1 BX2 BY2 X1 Y1 X2 Y2 minX maxX minY maxY CX CY CZ1 CZ2 confusion1]=fun(3,cov3,cov2,mean3,mean2,probc3,probc2,T3,T2,D3,D2,1,minX,maxX,minY,maxY);        
            figure
            plot(BX2,BY2,'.','Color',[0.5 0.5 1]),hold on,plot(BX1,BY1,'.','Color',[0.5 1 0.5 ]),plot(X2,Y2,'b.',X1,Y1,'g.'),legend('Class2','Class3'),axis([minX maxX minY maxY]),xlabel('x'),ylabel('y'),title(strcat(name,'-Classes:2&3'));
            
            % A & C
            
            len=len1+len3;
            probc1=len1/len;
            probc3=len3/len;
            cov1=diag(diag(cov1));
            cov3=diag(diag(cov3));
            [BX1 BY1 BX2 BY2 X1 Y1 X2 Y2 minX maxX minY maxY CX CY CZ1 CZ2 confusion1]=fun(3,cov1,cov3,mean1,mean3,probc1,probc3,T1,T3,D1,D3,1,minX,maxX,minY,maxY);        
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
        fprintf('\nConfusion Matrix : \n'),disp(confusion);
        fprintf('Classification Accuracy : '),disp(Accuracy);
        fprintf('Precision for Class1 : '),disp(Precision(1));
        fprintf('Precision for Class2 : '),disp(Precision(2));
        fprintf('Precision for Class3 : '),disp(Precision(3));
        fprintf('Mean Precision : '),disp(MeanPrecision);
        fprintf('Recall for Class1 : '),disp(Recall(1));
        fprintf('Recall for Class2 : '),disp(Recall(2));
        fprintf('Recall for Class3 : '),disp(Recall(3));
        fprintf('Mean Recall : '),disp(MeanRecall);
        fprintf('Fmeasure for Class1 : '),disp(Fmeasure(1));
        fprintf('Fmeasure for Class2 : '),disp(Fmeasure(2));
        fprintf('Fmeasure for Class3 : '),disp(Fmeasure(3));
        fprintf('Fmeasure Recall : '),disp(MeanFmeasure);
    end
end    