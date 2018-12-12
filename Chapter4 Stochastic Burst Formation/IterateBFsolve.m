

D=1;


uTargets=[0.1,0.4,1,4,10, 0.4,1,4];
ms= [0,0,0,0,0,1,1,1];

logSlopes= [0*ms;0*ms;0*ms];

Tfs= [25,27,30,33,36,40,43,46,50,55,60,65,70,77,85,93,100,110,120,130];

qqqCode=[];

for(qqq=6:length(uTargets))
    m=ms(qqq);
    uTarget=uTargets(qqq);
clear U
clear XI
clear Elfar

for(ttxt=1:length(Tfs))
    if(ttxt>1)
        deltaT= Tfs(ttxt)-Tfs(ttxt-1);
    end
    tf=Tfs(ttxt);
  %  try
        BackForwardSolveAdaptive;
        qqqCode=[qqqCode,qqq];
  %  catch
  %      warning('Something is broken')
  %      [qqq,ttxt]
  %      break;
  %  end
end

Addresses= find(qqqCode==qqq);
if(length(Addresses)>3)
logSlopes(2,qqq)= (log(longRecord(5,Addresses(end)))-log(longRecord(5,Addresses(floor((end+1)/2) ))))./(log(longRecord(3,Addresses(end)))-log(Addresses(floor((end+1)/2) ) ));
logSlopes(3,qqq)= (log(longRecord(5,Addresses(end)))-log(longRecord(5,Addresses(1))))./(log(longRecord(3,Addresses(end)))-log(longRecord(3,Addresses(1))));
else
        
end
end

[C,IA,IC] = uniquetol(longRecord([2,4],:)',10^-4,'ByRows',true)

figure();
hold on;
for(qqq= unique(IC)')
    indices= (qqq==IC);
    Addresses=find(indices);
logSlopes(1,qqq)= (log(longRecord(5,Addresses(end)))-log(longRecord(5,Addresses(floor((end+1)/3) ))))./(log(longRecord(3,Addresses(end)))-log(longRecord(3,Addresses(floor((end+1)/3) ) )));
logSlopes(2,qqq)= (log(longRecord(5,Addresses(end)))-log(longRecord(5,Addresses(floor((end+1)/2) ))))./(log(longRecord(3,Addresses(end)))-log(longRecord(3,Addresses(floor((end+1)/2) ) )));
logSlopes(3,qqq)= (log(longRecord(5,Addresses(end)))-log(longRecord(5,Addresses(1))))./(log(longRecord(3,Addresses(end)))-log(longRecord(3,Addresses(1))));
plot(longRecord(3,indices),longRecord(5,indices)); 
set(gca,'XScale','log','YScale','log')
end

%%Note, the rendering of all this is probably pretty stupid.
figure()
plot(longRecord(3,:),longRecord(5,:),'-s')
set(gca,'XScale','log','YScale','log')


figure();
plot(logSlopes);


