function [BX1 BY1 BX2 BY2 X1 Y1 X2 Y2 minX maxX minY maxY CX CY CZ1 CZ2 confusion] = fun(g,cov1,cov2,mean1,mean2,probc1,probc2,T1,T2,D1,D2,pair,mnx,mxx,mny,mxy)
        X1 = D1(:,1);
        Y1 = D1(:,2);
        X2 = D2(:,1);
        Y2 = D2(:,2);
        confusion=zeros(2,2);
            if(g==2)
                cov=cov1;
                w11 = Trans(Mult(Inv(cov),mean1));
                w12 = - (0.5*Mult(Mult(Trans(mean1),Inv(cov)),mean1)) + log(probc1);
                w21 = Trans(Mult(Inv(cov),mean2));
                w22 = - (0.5*Mult(Mult(Trans(mean2),Inv(cov)),mean2)) + log(probc2);
            elseif(g==1)
                cov=cov1;
                sigma=cov(1,1);
                w11 = Trans(mean1)/sigma;
                w12 = (Mult(Trans(mean1),mean1)/(((-2)*sigma))) + log(probc1) ;
                w21 = Trans(mean2)/sigma;
                w22 = (Mult(Trans(mean2),mean2)/(((-2)*sigma))) + log(probc2) ;
            elseif(g==3)
                w11 = Mult(Trans(mean1),Inv(cov1));
                w12 = log(probc1) - (0.5*Mult(Mult(Trans(mean1),Inv(cov1)),mean1))  - (0.5*log(abs(Mod(cov1))));
                w21 = Mult(Trans(mean2),Inv(cov2));
                w22 = log(probc2)  - (0.5*Mult(Mult(Trans(mean2),Inv(cov2)),mean2)) - (0.5*log(abs(Mod(cov2))));
            end
            for i = 1:length(T1)
                x = Trans(T1(i,:));
                if(g==2)
                    x1=g2(x,w11,w12);
                    x2=g2(x,w21,w22);
                elseif(g==1)
                    x1=g1(x,w11,w12);
                    x2=g1(x,w21,w22);   
                elseif(g==3)
                    x1=g3(x,cov1,w11,w12);
                    x2=g3(x,cov2,w21,w22);
                end
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
                x = Trans(T2(i,:)); 
                if(g==2)
                    x1=g2(x,w11,w12);
                    x2=g2(x,w21,w22);
                elseif(g==1)
                    x1=g1(x,w11,w12);
                    x2=g1(x,w21,w22);
                elseif(g==3)
                    x1=g3(x,cov1,w11,w12);
                    x2=g3(x,cov2,w21,w22);
                end
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
            if(pair==0)
                maxX=max(max(X1),max(X2));
                minX=min(min(X1),min(X2));
                maxY=max(max(Y1),max(Y2));
                minY=min(min(Y1),min(Y2));
                minX=minX-1;
                maxX=maxX+1;
                minY=minY-1;
                maxY=maxY+1;
            else
                minX=mnx;
                maxX=mxx;
                minY=mny;
                maxY=mxy;
            end
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
                    col = col+1;
                    CX(row,col)=bgx;
                    CY(row,col)=bgy;
                    x=[bgx;bgy];
                    if(g==2)
                        x1=g2(x,w11,w12);
                        x2=g2(x,w21,w22);
                    elseif(g==1)
                        x1=g1(x,w11,w12);
                        x2=g1(x,w21,w22);
                    elseif(g==3)
                        x1=g3(x,cov1,w11,w12);
                        x2=g3(x,cov2,w21,w22);
                    end
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
end