
if(~exist('D','var'))
D=1;
end


if(~exist('tf','var'))
tf=10;
end


if(~exist('uTarget','var'))
uTarget=10;
end


if(~exist('m','var'))
m=1;
end

UInitialConditions= @(x) 0;

if(exist('U','var') )
    Up=[0*U;U];
    tbasep=[tbase-tbase(2)*length(tbase)+deltaT,tbase+deltaT];
    uFunct= griddedInterpolant({xbase,tbasep},Up');
    'a'
else
uFunct= @(x,t) 0; %griddedInterpolant({xs,tsQ'},MQ)
'b'
end



    xbase = linspace(0,sqrt(4*D*tf)*5,800);
    tbase = linspace(0,tf,350);

    
dx= xbase(2);

StumpyBoundary= @(xl,ul,xr,ur,t) deal(0,1,ur,0);

ev= @(m,t,xmesh,umesh) myEventFunction(umesh,uTarget);

    %This part of the code is pretty hacky.
%MQ=[zeros(size(M,1),1),M];
%tsQ=[-1,ts]+1;
    %End hacky.
    
oldTotalCosts=50000;

if(~exist('ElFar','var'))
    ElFar=1/(tf+1/uTarget);
else
    if(exist('XI','var'))
        RawIntegral= 2.*sum( sum(XI.*XI,2)- 0.5*XI(:,1).^2 )*(xbase(2)-xbase(1))*(tbase(2)-tbase(1))
        EdgeIntegral= 2.*(sum( XI(end,:).^2)- 0.5*XI(end,1).^2)*(xbase(2)-xbase(1));
        ElFar
        ElFar=ElFar*1/(1+EdgeIntegral*deltaT/RawIntegral)
    end
end
ElFarStart=ElFar;

alphaIn=[];
ResultOut=[];


jumpFromLow=1;

Totalsteps=0;
        integrationAssistVector = 0*xbase; %This is a vector used to weight terms when in order to approximate our integral in polar coordinates.

if(m==1)
deltaR= xbase(2);

    XiInitialConditions= @(x) (x<deltaR).*(deltaR-x).*3/(pi*deltaR^2) ; %Initial condition is a cone of volume 1
        integrationAssistVector = 0*xbase; %This is a vector used to weight terms when in order to approximate our integral in polar coordinates.


Ars=xbase(2:end);

integrationAssistVector(1)= pi*deltaR.^2/3 %%Area of cone. "Height" given by what we multiply by.

integrationAssistVector(2:end)= (pi./deltaR).*...
   ( ( (Ars+deltaR).^3/6)-( (Ars+deltaR).*Ars.*Ars/2-Ars.^3/3) ...
        - ( (Ars-deltaR).^3/6)+( (Ars-deltaR).*Ars.*Ars/2-Ars.^3/3) );


elseif(m==0)
    XiInitialConditions= @(x) (x<dx)./dx; %How the hell do I pick a good ElFar....
integrationAssistVector=integrationAssistVector+2;
integrationAssistVector(1)=1;
integrationAssistVector=integrationAssistVector*xbase(2);
else
    error('bad m value');
end


if(~exist('ElFar','var'))
    ElFar=1/(tf+1/uTarget);
else
    
    if(exist('XI','var'))
      RawIntegral= sum( integrationAssistVector*(XI').^2 )*(tbase(2)-tbase(1));
        EdgeIntegral= integrationAssistVector*(XI(end,:))'.^2;
        ElFar
        ElFar=ElFar*1/(1+EdgeIntegral*deltaT/RawIntegral)
    end
end
if(isnan(ElFar))
    ElFar=1/(tf+1/uTarget);
end
ElFarStart=ElFar;



ExpectedAccuracyAlpha=10^-4;

for(ppq=1:6)
    jumpFromLow=0.25*jumpFromLow;
    
    backPDE= @(x,t,xi,DuDx) BackwardGoPde(x,t,xi,DuDx,uFunct,D,tf);
    solback = pdepe(m,backPDE,XiInitialConditions,StumpyBoundary,xbase,tbase);
    
    XI = solback(:,:,1);
                        %I'm pretty sure this constant flipping gives the
                        %surfaces we need...


       RawIntegral= sum( integrationAssistVector*(XI').^2 )*(tbase(2)-tbase(1));
      
       ElFarNow=0;
       ElFarOld=0;
       
       ElFarHigh=inf;
       ElFarLow=0;
       
       wupNow=0;
       wupOld=0;
       
       wupTarget= tf+1/uTarget;
       
       te=0;
       ue=0;

steps=0;

    while ( ((abs(te-tf)/abs(tf))>ExpectedAccuracyAlpha) || ((abs(ue-uTarget)/abs(uTarget))>ExpectedAccuracyAlpha) )
    Totalsteps=Totalsteps+1;
    steps=steps+1;
    XiFunct= griddedInterpolant({xbase,tbase},ElFar*XI');
        
    forwardPDE= @(x,t,u,DuDx) ForwardGoPde(x,t,u,DuDx,XiFunct,D,tf);
    [solForward,tsol,sole,te,ie] = pdepe(m,forwardPDE,UInitialConditions,StumpyBoundary,xbase,tbase,odeset('Events',ev));
    
    U = solForward(:,:,1);
    
    
    if(isempty(te))
        te=tf;
        ue=solForward(end,1,1);
        tooHigh=false;
        ElFarNow=ElFar;
        ElFarLow=ElFar;
        wupNow= te+1/ue;
    else
        te=te(1);
        ue=uTarget;
        tooHigh=true;
        ElFarNow=ElFar;
        ElFarHigh=ElFar;
        wupNow= te+1/ue;
    end
     
    slopeToUse=(ElFarOld-ElFarNow)/(wupOld-wupNow);
    
      
        if(ElFarOld==0)
                ElFar = (wupTarget-wupNow)/RawIntegral+ElFarNow;  
                   [ElFarNow,te,ue,1/RawIntegral,Totalsteps+0.001000001*steps]
%             if(slopeOld==0)    
%                 if(tooHigh)
%                     ElFar = 0.8*ElFarNow;  
%                 else
%                     ElFar = 1.2*ElFarNow;  
%                 end
%             else
%                 ElFar = (wupTarget-wupNow)*slopeOld+ElFarNow;  
%             end

        else
                ElFar = (wupTarget-wupNow)*(ElFarOld-ElFarNow)/(wupOld-wupNow)+ElFarNow;  
                  [ElFarNow,te,ue,slopeToUse,Totalsteps+steps*10^-5+10^-9]
        end
        
        
        %%If all else fails, relly on the bisection method.
        %%It ain't as clever as what we have above, but it has the notable
        %%advantage of NOT FAILING.
        if(ElFar<ElFarLow)
            if(ElFarHigh<10)
               ElFar=(ElFarLow+ElFarHigh)/2                
            elseif(ElFarLow>0)
                ElFar=ElFarLow*2; 
            else
              ElFar=2*wupTarget/RawIntegral;  
            end
        end
   
        
        if(isnan(ElFar))
            ElFar=1/(tf+1/uTarget);
        end %I REALLY do not want to allow nan's to develop.
        
        if(ElFar>ElFarHigh)
            ElFar=(ElFarLow+ElFarHigh)/2                
        end
        
        
        if(ElFarHigh<10 && rand()*steps>5)
            ElFar=(ElFarLow+ElFarHigh)/2;
        end
        
        slopeOld=slopeToUse;
        ElFarOld=ElFarNow;
        wupOld=wupNow;
     
        if((ElFarHigh-ElFarLow)<ElFar*10^-9)
            warning('The window is crazy small. Lets call this close enough.');
            break;
        end
       
        if(steps>150)
           error('Things are taking to long. Bailing out.');
        end
        
    end
    
    uFunct= griddedInterpolant({xbase,tbase},U');
    
    
    [ElFar,te,ue,RawIntegral*ElFar*ElFar]
    
    if(abs(oldTotalCosts-RawIntegral*ElFar*ElFar)/abs(oldTotalCosts+RawIntegral*ElFar*ElFar) < 10^-3)
        break;    
    end
    oldTotalCosts=RawIntegral*ElFar*ElFar;
    
end


if(exist('longRecord','var'))
    longRecord=[ longRecord, [ElFar;m;te;ue;ElFar*ElFar*RawIntegral;]];   
else
    longRecord=[ElFar;m;te;ue;ElFar*ElFar*RawIntegral];
end


%To view output, uncoment the below.
%  plot(U')
%figure();
%  plot(XI')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5

function [val,term,updown] = myEventFunction(umesh,uTarget)

val=max(max(max(umesh))-uTarget);
term=1;
updown=1;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [c,f,s] = BackwardGoPde(x,t,xi,DuDx,u,D,tf)
c = 1;
f = D*DuDx;
s = 2*u(x,tf-t)*xi;

end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [c,f,s] = ForwardGoPde(x,t,u,DuDx,xi,D,tf)
c = 1;
f = D*DuDx;
s = u^2 + xi(x,tf-t);
end


