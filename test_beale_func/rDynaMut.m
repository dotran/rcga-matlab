% The RDYNAMUT function performs dynamic mutation
% function [pop,nmutat]=rDynaMut(rcga,pop,gen)
% Input:
%    rcga- rcga variable, structure
%    pop- population of chromosomes, matrix
%    gen- generation
% Output:
%    pop- mutated population, matrix
%    nmutat- number of times mutation was performed
% Copyright (c) 2000 by Prof. Gang-Gyoo Jin, Korea Maritime University
%
function [pop,nmutat]= rDynaMut(rcga,pop,gen)
b= 5;
nmutat= 0;
for i= 1:rcga.popsize
	for j= 1:rcga.lchrom
		if (rand <= rcga.pmutat)
			nmutat= nmutat+1;
			r= rand;
			if(round(rand))
				pop(i,j)= pop(i,j)+(rcga.xub(j)-pop(i,j))*r*((1-gen/rcga.maxgen)^b+0.005);
			else
				pop(i,j)= pop(i,j)-(pop(i,j)-rcga.xlb(j))*r*((1-gen/rcga.maxgen)^b+0.005);
            end
		end
	end
end