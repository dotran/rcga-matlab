% The RGRADSEL function performs gradient-like selection
% function newpop= rGradSel(rcga,pop,fitness,chrombest,fitbest,etha)
% Input: 
%    rcga- rcga variable, structure
%    pop- population of chromosomes, matrix
%    fitness- fitness, vector
%    chrombest- best chromosome, vector
%    fitbest- fitness of the best chromesome
%    etha- parameter of the selection operator
% Output: 
%    newpop- mating pool, matrix 
% Copyright (c) 2000 by Prof. Gang-Gyoo Jin, Korea Maritime University
%
function newpop= rGradSel(rcga,pop,fitness,chrombest,fitbest,etha)
if(fitbest > 0)
	for i= 1:rcga.popsize
		normfit= etha*(1-fitness(i)/fitbest);
		pass= 0;
		while(pass == 0)
			pass= 1;
			for j= 1:rcga.lchrom
				newpop(i,j)= pop(i,j)+normfit*(chrombest(j)-pop(i,j));
				if(newpop(i,j) < rcga.xlb(j) | newpop(i,j) > rcga.xub(j))
					normfit= normfit*0.8;
					pass= 0;
					break;
				end
			end
		end
	end

else
	for i= 1:rcga.popsize
		k= Pickup(rcga.popsize);
		newpop(i,:)= pop(k,:);
	end
end