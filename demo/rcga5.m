%*************************************************************************%
% The RCGA5 implements a real coded genetic algorithm for finding the solution      %
%    of De Jong's test function 5                                                                                 %
%                                                                                                                                % 
%   Encoding:                                                                                                             %
%     - Real                                                                                                                % 
%                                                                                                                                % 
%  Genetic operators:                                                                                                %
%     - Tournament selection                                                                                      % 
%     - Arithmetical crossover                                                                                     %  
%     - Uniform mutation                                                                                              % 
%                                                                                                                                % 
%  Other strategies:                                                                                                    %
%     - Elitism                                                                                                              %
%                                                                                                                                % 
%  Remarks:                                                                                                               %
%                                                                                                                                % 
% Revision 1.2  1999/12/01                                                                                         %
% Copyright (c) 2000 by Prof. Gang-Gyoo Jin, Korea Maritime University                    % 
%*************************************************************************%

clear;

% initializes the generation counter
gen= 1;

% initializes the parameters of a RCGA
[rseed,maxmin,maxgen,popsize,lchrom,pcross,pmutat,xlb,xub,etha]= rInitPa5;

% creates a polulation randomly
pop= rInitPop(rseed,popsize,lchrom,xlb,xub);

% calculates the objective function value
objfunc= EvalObj5(pop,lchrom,popsize);

% calculates the fitness value
fitness= EvalFit5(objfunc,popsize);

% computes statistics
[chrombest,objbest,fitbest,objave,gam]= rStatPop(pop,objfunc,fitness,maxmin);

% builds a matrix storage for plotting line graphs
 stats(gen,:)=[gen objbest objave chrombest];

for gen= 2:maxgen

% prints the current generation
	fprintf('gen= %d\n',gen);

% applies reproduction
	 pop=TournSel(pop,popsize,fitness,2); % tournament selection with size of 2
%	pop= rGradSel(pop,popsize,lchrom,fitness,chrombest,fitbest,xlb,xub,etha);
                                                                                      % gradient-like selection
%	 pop= RemSel(pop,popsize,fitness); % remainder stochastic sample with replacement

% applies crossover
	[pop,nxover]= rArXover(pop,popsize,lchrom,pcross); % arithmetical crossover
%	[pop,nxover]= rMsXover(pop,popsize,lchrom,pcross); % modified simple crossover

% applies mutation
	[pop,nmutat]= rUnifMut(pop,popsize,lchrom,pmutat,xlb,xub); % uniform mutation
%	[pop,nmutat]= rDynaMut(pop,popsize,lchrom,pmutat,xlb,xub,gen,maxgen); %dynamic mutation

% calculates the objective function value
	objfunc= EvalObj5(pop,lchrom,popsize);

% applies Elitism
	[pop,objfunc]= rElitism(pop,objfunc,chrombest,objbest,maxmin);

% calculates the fitness value
	fitness= EvalFit5(objfunc,popsize);

% computes statistics
	[chrombest,objbest,fitbest,objave,gam]= rStatPop(pop,objfunc,fitness,maxmin);

% builds a matrix storage for plotting line graphs
	stats(gen,:)=[gen objbest objave chrombest];

end

% presents the population report
rRepPop(gen,pop,popsize,lchrom,objfunc,fitness,2);

% plots the best and average objective function values
subplot(2,1,1)
plot(stats(:,1),stats(:,2:3))

% plots the variables of the best chromosome
subplot(2,1,2)
plot(stats(:,1),stats(:,4:lchrom+3))