% The RCGA implements a real coded genetic algorithm for finding the solution      %
%    of Schwefel Function                                                                                  %
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
clf
clear all
clc
% initializes the parameters of a RCGA
rcga= rInitPa;

% creates a polulation randomly
pop= rInitPop(rcga);
plot(pop(:,1),pop(:,2),'ro'), hold on

% calculates the objective function value
objfunc= EvalObj(rcga,pop);

sfactor= 1.7;
% calculates the fitness value
fitness= objfunc;
scalefit= LinScale(fitness, sfactor);
%[pop objfunc fitness scalefit]
fitness= scalefit;
% computes statistics
rcga= rStatPop(rcga,pop,objfunc,fitness);
 
% % builds a matrix storage for plotting line graphs
buf= [];
% 
for gen= 1:rcga.maxgen
% applies reproduction
% 	pop= rGradSel(rcga,pop,fitness,1.8); % Gradient-like selection with etha=1.8
% 	 pop=TournSel(rcga,pop,fitness,2); % tournament selection with size of 2
	 pop= RemSel(rcga,pop,fitness); % remainder stochastic sample with replacement
% 
% % applies crossover
	[pop,nxover]= rArXover(rcga,pop); % arithmetical crossover
% % 	[pop,nxover]= rMsXover(rcga,pop); % modified simple crossover
% %    [pop,nxover]= rSpXover(rcga,pop); % simple crossover

% % applies mutation
[pop,nmutat]= rDynaMut(rcga,pop,gen); %dynamic mutation
% %	[pop,nmutat]= rUnifMut(rcga,pop); % uniform mutation
% % 
% % calculates the objective function value
  objfunc= EvalObj(rcga,pop);
% 
% applies Elitism
	[pop,objfunc]= rElitism(rcga,pop,objfunc,rcga.chrombest,rcga.objbest);
% 
% % calculates the fitness value
fitness= objfunc;
fitness= LinScale(fitness, sfactor);
% 
% computes statistics
rcga= rStatPop(rcga,pop,objfunc,fitness);
buf= [buf;gen rcga.objsofarbest rcga.chromsofarbest];
% %plot(pop(gen,1),pop(gen,2),'o'); hold on;
end
 
% % plots the best and average objective function values
figure
subplot(2,1,1)
plot(buf(:,1),buf(:,2))
% 
% % plots the variables of the best chromosome
subplot(2,1,2)
plot(buf(:,1),buf(:,3:4))
norm(rcga.chromsofarbest)
