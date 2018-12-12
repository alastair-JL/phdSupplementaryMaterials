CheckStability=true;


xIndex=4;

figure(xIndex); clf;
thm = struct('special', {{'EP','SN','HB','TB','MX'}},...
        'SN',{{'kd'  'MarkerFaceColor'  'g'  'MarkerSize'  [6.00]}},...
            'HB',{{'kd'  'MarkerFaceColor'  'r'  'MarkerSize'  [6.00]}},...
    'TB',{{'m*'  'MarkerFaceColor'  'c'  'MarkerSize'  [8.00]}},...
    'MX',{{'ko'  'MarkerFaceColor'  'w'  'MarkerSize'  [8.00]}});
thm.lspec= {{'k-','LineWidth',[2]},{'k:','LineWidth',[0.5]}}
hold on

listNames={};

for(ddd= 1: length(Ds) )
    for(eee= 1: length(Es))
        
       saveName= ['Carl_s' scaleChar 'D' num2str(Ds(ddd)) 'E' num2str(Es(eee)) '_E'];  
       listNames=[listNames,{saveName}];
       
       if(~isempty(coco_bd_val(coco_bd_read(saveName) ,1,'goalD'))) 
            coco_plot_bd(thm, saveName,'goalE','goalD','x',xIndex)
       else
           ([ saveName ' has failed'])
       end
       
       saveName= ['Carl_s' scaleChar 'D' num2str(Ds(ddd)) 'E' num2str(Es(eee)) '_D'];   
       listNames=[listNames,{saveName}];
       
       if(~isempty(coco_bd_val(coco_bd_read(saveName) ,1,'goalD'))) 
        coco_plot_bd(thm, saveName,'goalE','goalD','x',xIndex)
       else
           ([ saveName ' has failed'])
       end
       
    end
end

labelPrefix=['SpecialCurves_' scaleChar '_'];
figure(xIndex)
for(sss=1:labelnumber)
    savename=[labelPrefix, num2str(sss)];
    thm = struct('special', {{}});
    thm.lspec= {{LineColor{sss},'LineWidth',[2]},{{LineColor{sss},'LineWidth',[0.5]}}};
       
    if(size(coco_bd_read(savename),1)==2)
            ([ savename ' has failed'])               
    elseif(size(coco_bd_read(savename),2)==21) 
              coco_plot_bd(thm, savename,'goalE','goalD','x',xIndex)
    elseif(size(coco_bd_read(savename),2)==17)  
           coco_plot_bd(thm, savename,'goalE','goalD',names{xIndex})
    else
            ([ savename ' has failed'])           
    end
end
    
axis([0 2 0 2 0 4])

% 
figure(5) %%Create the "FlatPlot"
hold on

for(sss=1:labelnumber)
    savename=[labelPrefix, num2str(sss)];
    thm = struct('special', {{}});
    thm.lspec= {{LineColor{sss},'LineWidth',[2]},{{LineColor{sss},'LineWidth',[0.5]}}};
       
    if(size(coco_bd_read(savename),1)==2)
            ([ savename ' has failed'])               
    else    
          coco_plot_bd(thm, savename,'goalE','goalD')
    end
end
axis([0 2 0 2])
