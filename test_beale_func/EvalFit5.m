% The EVALFIT5 function converts objective function values into fitness
% function fitness= EvalFit5(objfunc,popsize)
% Input:
%    objfunc- objective function value, vector
%    popsize- population size
% Output:
%    fitness- fitness, vector
% Copyright (c) 2000 by Prof. Gang-Gyoo Jin, Korea Maritime University
%
function fitness= EvalFit5(objfunc,popsize)

fitness= 1./objfunc;
fitmin= min(fitness);
if(fitmin < 0)
	disp('Fitness is negative  !');
end