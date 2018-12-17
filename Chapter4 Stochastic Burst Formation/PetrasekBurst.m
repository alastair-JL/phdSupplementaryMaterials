%f = .088

% Size of gridcol
width = 256;
% Diffusion rates
da = (10^-5)*width*width;
noise=10^-1;

% 5,000 simulation seconds with 4 steps per simulated second
dt = .005;
stoptime = 1250;

t=0;
B=ones(width,width) + randn(size(B))*10^-3;
C=ones(width,width) + randn(size(B))*10^-3;
A=ones(width,width) + randn(size(B))*10^-3;




frametime = 0.5;
nextframe = 0;
tic

rangebounder= zeros(width,1)+0.97;
rangebounder(1,1)=1.03;


figure()

axes('Position',[0 0 1 1])
axis off
ha = image(A);
ha.CDataMapping = 'scaled';

ht = text(3,width-3,'Time = 0');
ht.Color = [.95 .2 .8];

figure()

axes('Position',[0 0 1 1])
axis off
hb = image(B);
hb.CDataMapping = 'scaled';


figure()
axes('Position',[0 0 1 1])
axis off
hc = image(C);
hc.CDataMapping = 'scaled';


%gamma=2;
%k0=-0.1;
colorbar
trigger=0%.001;



nframes = 1;

filename = 'PetrasekForThesis.gif';
nframes = 1;
        
%        caxis([0.05,0.15]);
        
        drawnow
        
alpha= 1;
beta=1;

while t<stoptime
    A = A + (da*my_laplacian(A) + alpha - beta.*C.*A)*dt;
    B = B + (da*my_laplacian(B) + beta.*C.*(A-B))*dt;
    C = C + (da*my_laplacian(C) - beta.*C.*(A-B))*dt;
    
    %hi.CData = A;   
    t = t+dt;
    ht.String = ['Time = ' num2str(floor(t))];

    if t > nextframe
        %hi.CData = [(A+B),rangebounder];
        ha.CData = [A,rangebounder];
        hb.CData = [B,rangebounder];
        hc.CData = [C,rangebounder];
        drawnow
        nextframe = nextframe + frametime;

    end

end


delta = toc;
disp([num2str(nframes) ' frames in ' num2str(delta) ' seconds']);