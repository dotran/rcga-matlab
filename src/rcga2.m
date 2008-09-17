% The RCGA2 implements a real coded genetic algorithm for finding the solution      %
%    of De Jong's test function 2                                                                                  %
%   Encoding:                                                                                                             %
%     - Real                                                                                                                % 
%                                                                                                                                % 
%  Genetic operators:                                                                                                %
%     - Gradient-like selection                                                                                     % 
%     - Modified simple crossover                                                                               %  
%     - Dynamic mutation                                                                                             % 
%                                                                                                                                % 
%  Other strategies:                                                                                                    %
%     - Elitism                                                                                                              %
%     - scaling window scheme                                                                                  %
%                                                                                                                                % 
%  Remarks:                                                                                                               %
%                                                                                                                                % 
% Revision 1.2  1999/12/01                                                                                         %
% Copyright (c) 2000 by Prof. Gang-Gyoo Jin, Korea Maritime University                    % 
%
clear;

% initializes the generation counter
gen= 0;

% initializes the parameters of a RCGA
rcga= rInitPa2;

% creates a polulation randomly
pop= rInitPop(rcga);

% % calculates the objective function value
 objfunc= EvalObj3(rcga,pop);

% finds gam
if(rcga.maxmin == 1)
	gam= min(objfunc);
else
	gam= min(-objfunc);
end

% calculates the fitness value
fitness= rScaleFit(rcga,objfunc,gam);

% computes statistics
[chrombest,objbest,fitbest,objave,gam]= rStatPop(rcga,pop,objfunc,fitness);

% builds a matrix storage for plotting line graphs
 stats=[gen objbest objave chrombest];

for gen= 1:rcga.maxgen

% prints the current generation
% 	fprintf('gen= %d\n',gen);

% applies reproduction
%	pop= rGradSel(rcga,pop,fitness,chrombest,fitbest,1.8); % Gradient-like selection with etha=1.8
%    pop= rDynaSel(rcga,pop,fitness,chrombest,fitbest);
% 	 pop=TournSel(rcga,pop,fitness,2); % tournament selection with size of 2
	 pop= RemSel(rcga,pop,fitness); % remainder stochastic sample with replacement
% 
% applies crossover
% 	[pop,nxover]= rMsXover(rcga,pop); % modified simple crossover
	[pop,nxover]= rArXover(rcga,pop); % arithmetical crossover
%    [pop,nxover]= rSpXover(rcga,pop); % simple crossover
% applies mutation
	[pop,nmutat]= rDynaMut(rcga,pop,gen); %dynamic mutation
%	[pop,nmutat]= rUnifMut(rcga,pop); % uniform mutation
% 
% calculates the objective function value
    objfunc= EvalObj3(rcga,pop);

% applies Elitism
	[pop,objfunc]= rElitism(rcga,pop,objfunc,chrombest,objbest);

% calculates the fitness value
    fitness= rScaleFit(rcga,objfunc,gam);
%    fitness= 1./(objfunc+0.05);
%   fitness= LinScale(fitness, 1.5); % sfactor=1.5
% 
% computes statistics
[chrombest,objbest,fitbest,objave,gam]= rStatPop(rcga,pop,objfunc,fitness);
 
% builds a matrix storage for plotting line graphs
stats= [stats;gen objbest objave chrombest];
%plot(pop(gen,1),pop(gen,2),'o'); hold on;
end
hold off;
%presents the population report
%rRepPop(rcga,pop,objfunc,fitness,2);

% plots the best and average objective function values
subplot(2,1,1)
plot(stats(:,1),stats(:,2:3))

% plots the variables of the best chromosome
subplot(2,1,2)
plot(stats(:,1),stats(:,4:rcga.lchrom+3))
stats(end,4)