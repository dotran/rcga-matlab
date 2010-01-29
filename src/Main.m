function Main
% Main program to implement Real-Coded Genetic Algorithms
% Notes: ver. 3
%   function handle is NOT used, test functions are now stored in TestBed.m
% Created: 2009.12.11
% Modified: 2010.01.29

% clc
clear all

% Initialize parameters
% ga.randseed = 123;

funcID = 9;
funcinfo = TestBed(funcID,1,0);
EC.lchrom = funcinfo.dim;
EC.lobnd = funcinfo.bnd(1,:);
EC.upbnd = funcinfo.bnd(2,:);
EC.probtype = -1; % 1: maximization problem, -1: minimization problem

EC.maxgen = 2500;
EC.popsize = 100;
EC.pcross = 0.8;
EC.pmutat = 0.05;

EC.elitcount = 1; % number of elitists
EC.elitindex = zeros(EC.elitcount,1);
EC.elitchrom = zeros(EC.elitcount,EC.lchrom);
EC.elitobjafit = zeros(EC.elitcount,2); % elitist(s) obj AND fit

EC.curgen = 0; % current generation
EC.pop = zeros(EC.popsize, EC.lchrom);
EC.obj = zeros(EC.popsize, 1);
EC.fit = zeros(EC.popsize, 1);
% EC.parentpop = zeros(EC.popsize, EC.lchrom);
% EC.parentobj = zeros(EC.popsize, 1);
% EC.parentfit = zeros(EC.popsize, 1);
% EC.childpop = zeros(EC.popsize, EC.lchrom);
% EC.childobj = zeros(EC.popsize, 1);
% EC.childfit = zeros(EC.popsize, 1);

EC.stat.bestindex = 0;
EC.stat.bestchrom = zeros(1,EC.lchrom);
EC.stat.bestobj = 0;
EC.stat.bestfit = 0;
EC.stat.worstobj = 0;
EC.stat.averobj = 0;

bestobj = zeros(EC.maxgen, 1);
averobj = zeros(EC.maxgen, 1);

mean_of_bestobj = [];
for run=1:100
EC.randseed = 195*run + 327;
EC.pop = InitializePop(EC); % Initialize population
EC.obj = evaluation(funcID, EC.pop, EC.popsize);
EC.fit = fitness(EC.obj, EC.probtype);
EC.stat = popstatistics(EC.probtype, EC.pop, EC.obj, EC.fit);
for t=1:EC.maxgen
    EC.curgen = t;
    % Fitness Scaling should be located here
    EC.pop = Sel_RWheel(EC); % Roulette wheel selection: ***KQua ko tot nhu simulation in C co the la do fitness scaling
    EC.pop = Cross_Arith(EC); % Arithmetic crossover
    EC.pop = Mut_Dynamic(EC, 6); % Dynamic mutation
    % Evaluation of objective function values
    EC.obj = evaluation(funcID, EC.pop, EC.popsize);
    % Fitnesses caculation for the newly generated population
    EC.fit = fitness(EC.obj, EC.probtype);
    [EC.pop, EC.obj, EC.fit] = Elitism(EC);
    % Statistics
    EC.stat = popstatistics(EC.probtype, EC.pop, EC.obj, EC.fit);
bestobj(t,1) = EC.stat.bestobj;
averobj(t,1) = EC.stat.averobj;
end
% plot(1:EC.maxgen,bestobj,'r', 1:EC.maxgen,averobj,'b')
% semilogy(1:EC.maxgen,bestobj,'r', 1:EC.maxgen,averobj,'b')
mean_of_bestobj = [mean_of_bestobj; EC.stat.bestobj];
end
mean_of_bestobj_in_100runs = mean(mean_of_bestobj)
% fprintf('\nbestoj = %1.5e\n', bestobj(end))
% fprintf('averobj = %1.5e\n', averobj(end))

%================>>================>>=================>>===================

function stat = popstatistics(probtype, pop, obj, fit)
% Population statistics
stat.bestindex = 0;
stat.bestobj = 0;
stat.bestfit = 0;
stat.worstobj = 0;
stat.averobj = 0;
if (probtype == 1)
    [stat.bestobj, stat.bestindex] = max(obj);
    stat.worstobj = min(obj);
else
    [stat.bestobj, stat.bestindex] = min(obj);
    stat.worstobj = max(obj);
end
stat.bestfit = fit(stat.bestindex);
stat.bestchrom = pop(stat.bestindex,:);
stat.averobj = mean(obj);

function fit = fitness(obj, probtype)
% Fitness calculation
if (probtype == 1)
    gamma = min(obj);
    fit = obj - gamma + eps; % + epsilon: weakest individual may have chance to survive
else
    gamma = min(-obj);
    fit = -obj - gamma + eps;
end

function obj = evaluation(funcID, pop, popsize)
% Evaluate objective function values
obj = zeros(popsize, 1);
for i=1:popsize
    obj(i,1) = TestBed(funcID, 0, pop(i,:));
end

