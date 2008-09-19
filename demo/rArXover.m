% The RARXOVER function performs arithmetical crossover
% function [pop,nxover]= rArXover(rcga,pop)
% Input:
%    rcga- rcga variable, structure
%    pop- population of chromosomes, matrix
% Output:
%    pop- mated population, matrix
%    nxover- number of times crossover was performed
% Copyright (c) 2008 by Prof. Gang-Gyoo Jin, Korea Maritime University
%
function [pop,nxover]= rArXover(rcga,pop)

nxover= 0;
halfpop= floor(rcga.popsize/2);
for i= 1:halfpop
	if (rand <= rcga.pcross)
		nxover= nxover+1;
       mate1= 2*i-1;
       mate2= 2*i;
		lam= rand;
		temp= lam*pop(mate2,:)+(1-lam)*pop(mate1,:);

		lam= rand;
		pop(mate2,:)= lam*pop(mate1,:)+(1-lam)*pop(mate2,:);
		pop(mate1,:)= temp;
	end
end
