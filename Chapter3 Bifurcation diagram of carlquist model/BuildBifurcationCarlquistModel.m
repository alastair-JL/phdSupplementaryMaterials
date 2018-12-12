%% This file will build 
%%




Ds=[3  9  15];  %% These give the Ds and Es values RELATIVE to those
Es=[3  9  15];  %% used in experiment. These are divided by ten and used as starting points in our bifurcation diagram.
%%Hence, [3 9 15] means we will try starting points at 0.3, 0.9 and 1.5 times the experimental concentration level.


AssumedScale= 1e+04; %%This number gives "h". Our system will be effected by both saturation AND depletion when h = O(10^4)
%% If h is larger, saturation dominates, is smaller depletion dominates.

scaleChar='4'; %This is the scale char. It helps to name files. I usually use the log of h.



Carlquist= @(x,p) dudt(x,p);
Carlquist_du= @(x,p) dudt_du(x,p);
Carlquist_dp= @(x,p) dudt_dp(x,p);


continuationNumber=1500;

SaddleNodeNumber=0;

listNames={}

for(ddd= 1: length(Ds))
    
    for(eee= 1: length(Es))
        p0= [Ds(ddd)/10;Es(eee)/10;AssumedScale];

    Best=[-1;-1;-1;-1];
    attempts=100;
    
        while(any(Best<0)|| (norm(Carlquist(Best,p0))>10^-5) || [1,1,2,0]*Best>p0(1)*p0(3) ||...
           [0,1,1,1]*Best>p0(2)*p0(3) || (max(real(eig(dudt_du(Best,p0))))>0 && (rand()<0.9)) )
        Best= rand(4,1)*0.5*p0(3);
            attempts=attempts-1;
            
        for(qqq=1:50)
            Best=Best- Carlquist_du(Best,p0)\Carlquist(Best,p0);
            norm(Carlquist(Best,p0))
        end
            if(attempts<0)
                break;
            end
        end
      
        prob = coco_prob();
        prob = coco_set(prob, 'ode', 'vectorized', false);
        prob = coco_set(prob, 'cont', 'PtMX', continuationNumber);
        prob = coco_set(prob, 'cont', 'h_min', 0.01);
        prob = coco_set(prob, 'cont', 'h_max', 1);
        prob = coco_set(prob, 'corr', 'ItMX', 50);

        ode_fcns = {Carlquist,Carlquist_du,Carlquist_dp};

        prob = ode_isol2ep(prob, '', ode_fcns{:}, Best, {'goalD' 'goalE','scale'}, p0);
        prob= coco_add_func(prob, 'Turing', @turingDetector, [], 'regular', 'Turing','uidx', [1:7]);
        prob = coco_add_event(prob, 'TB', 'special point', 'Turing', 0);

       saveName= ['Carl_s' scaleChar 'D' num2str(Ds(ddd)) 'E' num2str(Es(eee)) '_D'];
        bd=coco(prob, saveName, [], 1, {'goalD' 'goalE','scale'}, [0.03, 2]);

        
        prob = coco_prob();
        prob = coco_set(prob, 'ode', 'vectorized', false);
        prob = coco_set(prob, 'cont', 'PtMX', continuationNumber);
        prob = coco_set(prob, 'cont', 'h_min', 0.01);
        prob = coco_set(prob, 'cont', 'h_max', 1);
        prob = coco_set(prob, 'corr', 'ItMX', 50);

        ode_fcns = {Carlquist,Carlquist_du,Carlquist_dp};

        prob = ode_isol2ep(prob, '', ode_fcns{:}, Best, {'goalD' 'goalE','scale'}, p0);

        prob= coco_add_func(prob, 'Turing', @turingDetector, [], 'regular', 'Turing','uidx', [1:7]);
        prob = coco_add_event(prob, 'TB', 'special point', 'Turing', 0);


       saveName= ['Carl_s' scaleChar 'D' num2str(Ds(ddd)) 'E' num2str(Es(eee)) '_E'];
        bd=coco(prob, saveName, [], 1, {'goalE' 'goalD','scale'}, [0.03, 2]);
    
    listNames=[listNames,saveName];
        
    end

end


labelPrefix= ['SpecialCurves_' scaleChar '_'];
ScanForAnythingInteresting;
drawStuff;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [data, y] = turingDetector(opts, data, u)
y= max(real(eig(dudtJacob(u))));  
end
