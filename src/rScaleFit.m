% The rSCALEFIT function converts objective function values into fitness
% using the scaling window scheme(window size= 1)
% function fitness= rScaleFit(rcga,objfunc,gam)
% Input:
%    rcga- rcga variable, structure
%    objfunc- objective function value, vector
%    gam- minimun of objfunc or -objfunc in the previous population 
% Output:                                           
%    fitness- scaled fitness, vector  
% Copyright (c) 2008 by Prof. Gang-Gyoo Jin, Korea Maritime University
%
function fitness= rScaleFit(rcga,objfunc,gam)

if(rcga.maxmin == 1)
	fitness= objfunc-gam;
else
	fitness= -objfunc-gam;
end
for i=1:rcga.popsize
	if(fitness(i) < 0)
		fitness(i)= 0;
	end
end
