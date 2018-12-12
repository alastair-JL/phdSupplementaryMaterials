%f = .088

% Size of gridcol
width = 256;
% Diffusion rates
da = (10^-4)*width*width;
noise=10^-1;

% 5,000 simulation seconds with 4 steps per simulated second
dt = .05;
stoptime = 15000;


 A=zeros(width,width);
 A= randn(size(A))*10/width;
 t=0;

h=figure();

frametime = 0.5;
nextframe = 0;
tic

rangebounder= zeros(width,1);
rangebounder(1,1)=2;

axes('Position',[0 0 1 1])
axis off
hi = image(A);
hi.CDataMapping = 'scaled';

ht = text(3,width-3,'Time = 0');
ht.Color = [.95 .2 .8];

colorbar
trigger=0%.001;



nframes = 1;

filename = 'CartoonModelForThesis_IC.gif';
nframes = 1;
        hi.CData = [A,rangebounder];
        
%        caxis([0.05,0.15]);
        
        drawnow
       
        frame = getframe(h); 
        im = frame2im(frame); 
        [imind,cm] = rgb2ind(im,256); 
        
imwrite(imind,cm,filename,'gif', 'Loopcount',0,'DelayTime',0); 
firstSpike=true;

while t<stoptime
    A = A + (da*my_laplacian(A) + A.^2.*(2-A) )*dt;
    %hi.CData = A;   
    t = t+dt;
    ht.String = ['Time = ' num2str(floor(t)) ];

    if t > nextframe
%     bob=[(B-mean(mean(B)))/sqrt(mean(var(B)))];%[ (A-mean(mean(A)))/sqrt(mean(var(A))) ,(B-mean(mean(B)))/sqrt(mean(var(B)))];%,rangebounder];
        hi.CData = [A,rangebounder];
        drawnow
        nextframe = nextframe + frametime;

        frame = getframe(h); 
        im = frame2im(frame); 
        [imind,cm] = rgb2ind(im,256); 
        imwrite(imind,cm,filename,'gif','WriteMode','append');         
       
        if(firstSpike && max(max(A))>1)
            warning('FirstSpike is here');
            firstSpike=false;
        end
            
        nframes = nframes+1;    
    end

end
delta = toc;
disp([num2str(nframes) ' frames in ' num2str(delta) ' seconds']);