function Main_BackupVer0
% Main program to implement real-coded genetic algorithms
% Notes: Worked perfectly

clc
clear all

% Initialize parameters
ga.randseed = 123;

ga.probtype = -1; % 1: maximization problem, -1: minimization problem

ga.maxgen = 1000;

ga.popsize = 100;
ga.lchrom = 30;
ga.pcross = 0.8;
ga.pmutat = 0.05;

ga.elitcount = 1; % number of elitists
ga.elitindex = zeros(ga.elitcount,1);
ga.elitchrom = zeros(ga.elitcount,ga.lchrom);
ga.elitobjafit = zeros(ga.elitcount,2); % elitist(s) obj AND fit

ga.curgen = 0; % current generation

ga.pop = zeros(ga.popsize, ga.lchrom);
ga.obj = zeros(ga.popsize, 1);
ga.fit = zeros(ga.popsize, 1);

ga.stat.bestindex = 0;
ga.stat.bestchrom = zeros(1,ga.lchrom);
ga.stat.bestobj = 0;
ga.stat.bestfit = 0;
ga.stat.worstobj = 0;
ga.stat.averobj = 0;

ga.lobnd = -100*ones(1,ga.lchrom);
ga.upbnd = +100*ones(1,ga.lchrom);

bestobj = zeros(ga.maxgen, 1);
averobj = zeros(ga.maxgen, 1);

% if (rem(ga.popsize,2)~=0)
%     ga.popsize = ga.popsize + 1;
% end

mean_of_bestobj = [];
for run=1:1
ga.randseed = 195*run + 37;
funchandle = @objfunc1;
ga.pop = InitializePop(ga); % Initialize population
ga.obj = evaluation(funchandle,ga.pop,ga.popsize);
ga.fit = fitness(ga.obj, ga.probtype);
ga.stat = popstatistics(ga);

for t=1:ga.maxgen
    ga.curgen = t;
    % Fitness Scaling should be located here
    ga.pop = sRouletteWheel(ga); % Roulette wheel selection
    ga.pop = xArithmetic(ga); % Arithmetic crossover
    ga.pop = mDynamic(ga,6); % Dynamic mutation
    ga.obj = evaluation(funchandle,ga.pop,ga.popsize);
    ga.fit = fitness(ga.obj,ga.probtype);
    [ga.pop,ga.obj,ga.fit] = Elitism(ga);
    ga.stat = popstatistics(ga);
bestobj(t,1) = ga.stat.bestobj;
averobj(t,1) = ga.stat.averobj;
end
plot(1:ga.maxgen,bestobj,'r', 1:ga.maxgen,averobj,'b')
% ga.averobj
% % ga.stat.bestobj
mean_of_bestobj = [mean_of_bestobj; ga.stat.bestobj];
end
mean_of_bestobj_in_100runs = mean(mean_of_bestobj)


function stat = popstatistics(ga)
% Population statistics
stat.bestindex = 0;
stat.bestchrom = zeros(1,ga.lchrom);
stat.bestobj = 0;
stat.bestfit = 0;
stat.worstobj = 0;
stat.averobj = 0;
if (ga.probtype == 1)
    [stat.bestobj, stat.bestindex] = max(ga.obj);
    stat.worstobj = min(ga.obj);
else
    [stat.bestobj, stat.bestindex] = min(ga.obj);
    stat.worstobj = max(ga.obj);
end
stat.bestfit = ga.fit(stat.bestindex);
stat.bestchrom = ga.pop(stat.bestindex,:);
stat.averobj = mean(ga.obj);

function fit = fitness(obj, probtype)
% Fitness calculation
if (probtype == 1)
    gamma = min(obj);
    fit = obj - gamma + eps; % + epsilon: weakest individual may have chance to survive
else
    gamma = min(-obj);
    fit = -obj - gamma + eps;
end

function obj = evaluation(funchandle, pop, popsize)
% Evaluate objective function values
obj = zeros(popsize, 1);
for i=1:popsize
    obj(i,1) = funchandle(pop(i,:));
end

function f = objfunc1(x)
% Definition of objective funtion
f = sum(x.^2);

