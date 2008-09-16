% The RSTATPOP function calculates the statistics of a population
% function [chrombest,objbest,fitbest,objave,gam]= rStatPop(rcga,pop,objfunc,fitness)
% Input:
%    rcga- rcga variable, structure
%    pop- population, matrix
%    objfunc- objective function value, vector
%    fitness- fitness, vector                
% Output:
%    chrombest- best chromosome, vector
%    objbest- best objective function value 
%    fitbest- fitness of the best chromesome 
%    objave- average objective function value
%    gam- minimun of objfunc or -objfunc 
% Copyright (c) 2000 by Prof. Gang-Gyoo Jin, Korea Maritime University
%
function [chrombest,objbest,fitbest,objave,gam]= rStatPop(rcga,pop,objfunc,fitness)

if(rcga.maxmin == 1)
	[objbest, index]= max(objfunc);
	gam= min(objfunc); 
else
	[objbest, index]= min(objfunc);
	gam= min(-objfunc); 
end
chrombest= pop(index,:);
fitbest= fitness(index);
objave= mean(objfunc);
