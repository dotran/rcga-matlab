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
function newpop= rDynaSel(rcga,pop,fitness,chrombest,fitbest)
if(fitbest > 0)
    A= zeros(rcga.lchrom);
 	for j= 1:rcga.lchrom-1
         A(j,j+1)= 0.01;    
     end
    for i= 1:rcga.popsize
        e= pop(i,:)-chrombest;
		normfit= fitness(i)/fitbest;
    	for j= 1:rcga.lchrom
            A(j,j)= normfit;
        end
        newe= A*e';
        newpop(i,:)= newe'+chrombest;
%        [pop(i,:);newpop(i,:);chrombest]
%        pause;
    end
    
else
	for i= 1:rcga.popsize
		k= Pickup(rcga.popsize);
		newpop(i,:)= pop(k,:);
	end
end