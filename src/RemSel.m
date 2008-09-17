% The REMSEL function performs remainder stochastic sample with replacement
% function newpop= RemSel(rcga,pop,fitness)
% Input:
%    rcga- rcga variable, structure
%    pop- population of chromosomes, matrix
%    fitness- fitness of chromesomes, vector
% Output:
%    newpop- mating pool, matrix
% Copyright (c) 2000 by Prof. Gang-Gyoo Jin, Korea Maritime University
%
function newpop= RemSel(rcga,pop,fitness)

fitsum= sum(fitness);
if(fitsum ~= 0)
	expect= rcga.popsize*fitness/fitsum;
	nassign= floor(expect);
	nsel=0;
	for i= 1:rcga.popsize
		na= nassign(i);
		while(na > 0)
			na= na-1;
			nsel= nsel+1;
			idxchrom(nsel)= i;
		end
	end
	if(nsel < rcga.popsize)
		nrem= rcga.popsize-nsel;
		psel= (expect-	nassign)/nrem;
		cumpsel= cumsum(psel);
		for i= (nsel+1):rcga.popsize
			k= 1;
			test= rand;
			while(test > cumpsel(k))
				k= k+1;
			end
			idxchrom(i)= k;
		end
	end

else
	idxchrom= [1:rcga.popsize];
end
newpop= Select(pop,rcga.popsize,idxchrom);
