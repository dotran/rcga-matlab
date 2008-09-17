% The RUNIFPMUT function performs uniform mutation
% function [pop,nmutat]= rUnifMut(rcga,pop)
% Input:
%    rcga- rcga variable, structure
%    pop- population of chromosomes, matrix
% Output:
%    pop- mutated population, matrix
%    nmutat- number of times mutation was performed
% Copyright (c) 2000 by Prof. Gang-Gyoo Jin, Korea Maritime University
%
function [pop,nmutat]= rUnifMut(rcga,pop)

nmutat= 0;
for i= 1:rcga.popsize
	for j= 1:rcga.lchrom
		if (rand <= rcga.pmutat)
			nmutat= nmutat+1;
			pop(i,j)= (rcga.xub(j)-rcga.xlb(j))*rand+rcga.xlb(j);
		end
	end
end