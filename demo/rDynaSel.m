% The DYNASEL function performs dynamic system-like selection
% function newpop= rDynaSel(rcga,pop,fitness,chrombest,fitbest,etha)
% Input: 
%    rcga- rcga variable, structure
%    pop- population of chromosomes, matrix
%    fitness- fitness, vector
%    chrombest- best chromosome, vector
%    fitbest- fitness of the best chromesome
% Output: 
%    newpop- mating pool, matrix 
% Copyright (c) 2000 by Prof. Gang-Gyoo Jin, Korea Maritime University
%
function newpop= rDynaSel(rcga,pop,fitness,etha0)
lam= 0.1;
A= [1-lam lam;lam 1-lam];
if(rcga.fitbest > 0)
	for i= 1:rcga.popsize
		normfit= 1-fitness(i)/rcga.fitbest;
        etha= etha0;
        pass= 0;
		while pass == 0
            xi= etha*normfit;
			newpop(i,:)= A*((1-xi)*pop(i,:)'+xi*rcga.chrombest');
			for j= 1:rcga.lchrom
				if(newpop(i,j) < rcga.xlb(j) | newpop(i,j) > rcga.xub(j))
					pass= 0;
                    break;
                else
                    pass= 1;
				end
            end
            etha= etha-0.1;
		end
    end
else
	for i= 1:rcga.popsize
		k= Pickup(rcga.popsize);
		newpop(i,:)= pop(k,:);
	end
end
