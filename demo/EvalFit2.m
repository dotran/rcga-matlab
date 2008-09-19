% The EVALFIT2 function converts objective function values into fitness
% function fitness= EvalFit2(objfunc,popsize)
% Input:
%    objfunc- objective function value, vector
%    popsize- population size
% Output:
%    fitness- fitness, vector
% Copyright (c) 2000 by Prof. Gang-Gyoo Jin, Korea Maritime University
%
function fitness= EvalFit2(objfunc,popsize)

fitness= 1./(objfunc+0.1);
fitmin= min(fitness);
if(fitmin < 0)
	disp('Fitness is negative  !');
end