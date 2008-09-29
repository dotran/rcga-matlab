% The RSTATPOP function calculates the statistics of a population
% function rStatPop(rcga,pop,objfunc,fitness)
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
function rcga= rStatPop(rcga,pop,objfunc,fitness)
if(rcga.maxmin == 1)
	[rcga.objbest, index]= max(objfunc);
    if rcga.objbest > rcga.objsofarbest
        rcga.objsofarbest= rcga.objbest;
        rcga.chromsofarbest= pop(index,:);
        rcga.fitsofarbest= fitness(index);
    end
	rcga.gam= min(objfunc); 
else
	[rcga.objbest, index]= min(objfunc);
    if rcga.objbest < rcga.objsofarbest
        rcga.objsofarbest= rcga.objbest;
        rcga.chromsofarbest= pop(index,:);
        rcga.fitsofarbest= fitness(index);
    end
	rcga.gam= min(-objfunc); 
end
rcga.chrombest= pop(index,:);
rcga.fitbest= fitness(index);
rcga.objave= mean(objfunc);
