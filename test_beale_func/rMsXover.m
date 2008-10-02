% The RMSXOVER function performs modified simple crossover
% function [pop,nxover]= rMsXover(rcga,pop)
% Input:
%    rcga- rcga variable, structure
%    pop- population of chromosomes, matrix
% Output:
%    pop- mated population, matrix
%    nxover- number of times crossover was performed
% Copyright (c) 2008 by Prof. Gang-Gyoo Jin, Korea Maritime University
%
function [pop,nxover]= rMsXover(rcga,pop)

nxover= 0;
halfpop= floor(rcga.popsize/2);
for i= 1:halfpop
	if (rand <= rcga.pcross)
		nxover= nxover+1;
       mate1= 2*i-1;
       mate2= 2*i;
		xpoint= Pickup(rcga.lchrom-1);
		lam= rand;
		temp= lam*pop(mate2,xpoint)+(1-lam)*pop(mate1,xpoint);
		lam= rand;
		pop(mate2,xpoint)= lam*pop(mate1,xpoint)+(1-lam)*pop(mate2,xpoint);
		pop(mate1,xpoint)= temp;

		temp= pop(mate1,xpoint+1:rcga.lchrom);
		pop(mate1,xpoint+1:rcga.lchrom)= pop(mate2,xpoint+1:rcga.lchrom);
		pop(mate2,xpoint+1:rcga.lchrom)= temp;
	end
end

