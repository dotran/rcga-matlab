% The RELITISM function performs elitism function
% [pop,objfunc]=rElitism(rcga,pop,objfunc,chrombest,objbest)
%    rcga- rcga variable, structure
%    pop- population of chromosomes, matrix
%    objfunc- objective function value
%    chrombest- best chromosome, vector
%    objbest- best objective function value
% Output:
%    pop- modified population of chromosomes, matrix
%    objfunc- modified objective function value
% Copyright (c) 2000 by Prof. Gang-Gyoo Jin, Korea Maritime University
%
function [pop,objfunc]= rElitism(rcga,pop,objfunc,chrombest,objbest)

if(rcga.maxmin==1)
	cobjbest= max(objfunc);
	if(cobjbest < objbest)
	  [objworst, index]= min(objfunc);
	  pop(index,:)= chrombest;
	  objfunc(index)= objbest;
	end
else
	cobjbest= min(objfunc);
	if(cobjbest > objbest)
	  [objworst, index]= max(objfunc);
	  pop(index,:)= chrombest;
	  objfunc(index)= objbest;
	end
end
