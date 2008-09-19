function Demo_rcga2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Demo program for tuning the PI controller using a RCGA %
clf;

% initializes the parameters of a RCGA
rcga= rInitPa2;

% creates a polulation randomly
pop= rInitPop(rcga);
 
% calculates the objective function value
objfunc= EvalObj2(rcga,pop);

% sets initial 'gam' for the scaling window scheme
if(rcga.maxmin == 1)
	rcga.gam= min(objfunc); 
else
	rcga.gam= min(-objfunc); 
end

% scaling window scheme of the window size= 1
fitness= rScaleFit(rcga,objfunc);

% linear scaling
sfactor= 1.7;
scalefit= LinScale(fitness, sfactor);

% computes statistics
rcga= rStatPop(rcga,pop,objfunc,fitness);

% builds a storage for plotting graphs
buf= [0 rcga.objsofarbest rcga.chromsofarbest];

% plots the obj_sofarbest on Window 1
subplot(2,1,1)
gh1= plot(buf(:,1),buf(:,2));
axis([0 rcga.maxgen 0 1000])
grid on

% plots the x_sofarbest on Window 2
subplot(2,1,2)
gh2= plot(buf(:,1),buf(:,3)); hold on;
gh3= plot(buf(:,1),buf(:,4));
axis([0 rcga.maxgen 0 5])
grid on

for gen= 1:rcga.maxgen
% applies reproduction
 pop= RemSel(rcga,pop,fitness); % remainder stochastic sample with replacement
% pop= TournSel(rcga,pop,fitness,5);
% pop= rGradSel(rcga,pop,fitness,1.8); % Jin's selection with etha=1.8

% applies crossover
	[pop,nxover]= rArXover(rcga,pop); % arithmetical crossover

% applies mutation
    [pop,nmutat]= rDynaMut(rcga,pop,gen); %dynamic mutation

% calculates the objective function value
    objfunc= EvalObj2(rcga,pop);

% applies Elitism
	[pop,objfunc]= rElitism(rcga,pop,objfunc);

% calculates the fitness value
    fitness= rScaleFit(rcga,objfunc);
    scalefit= LinScale(fitness, sfactor);
 
% computes statistics
    rcga= rStatPop(rcga,pop,objfunc,fitness);

% builds a storage for plotting graphs
    buf= [buf;gen rcga.objsofarbest rcga.chromsofarbest];
  
% plots the best and average objective function values
    subplot(2,1,1)
    set(gh1,'xdata',buf(:,1),'ydata',buf(:,2))

% plots the variables of the best chromosome
    subplot(2,1,2)
    set(gh2,'xdata',buf(:,1),'ydata',buf(:,3))
    set(gh3,'xdata',buf(:,1),'ydata',buf(:,4))
    drawnow
end
hold off
rcga.objsofarbest 
rcga.chromsofarbest


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% The EVALOBJ2 function
function objfunc= EvalObj2(rcga,pop);
loop= 600; h= 0.05;
for i= 1:rcga.popsize  
    t= 0; x= [0;0]; yr= 1; z= 0; ee= yr- x(1); ff= 0;
    Kp= pop(i,1); Ki= pop(i,2);
    tt= t; yy= x(1);objfunc(i,1)= 0;
    for j= 1: loop
        e= yr-x(1);
        z= z+0.5*h*(e+ee);
        ee= e;
        u= Kp*e+Ki*z;
        if u > 5
            u= 5;
        end
        x= RK4(@Plant, t, x, u, h);
        t= t+h;
        tt= [tt;t]; yy= [yy;x(1)];
        f= 30*e*e+u*u;
        objfunc(i,1)= objfunc(i,1)+0.5*h*(f+ff);
        ff= f;
    end
    [Mp,tp,tr,ts3,ts5,ess] = Tstats(tt,yy,yr);
    w1= 100; w2= 10; w3= 100;
    if Mp > 5
        objfunc(i,1)= objfunc(i,1)+ w1*(5-Mp)*(5-Mp);
    end
    if tr > 1.1
        objfunc(i,1)= objfunc(i,1)+ w2*(1.1-tr)*(1.1-tr);
    end
    if ts5 > 5.5
        objfunc(i,1)= objfunc(i,1)+ w3*(5.5-ts5)*(5.5-ts5);
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function xdot= Plant(t, x, u)
%k= 1; wn= 1; zeta= 0.9;
xdot(1)= x(2);
xdot(2)= -x(1)-1.8*x(2)+u;
xdot= xdot';



