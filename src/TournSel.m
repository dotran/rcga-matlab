% The TOURNSel function performs tournament selection
% function newpop= TournSel(rcga,pop,fitness,tsize)
% Input:                 
%    rcga- rcga variable, structure
%    pop- population of chromosomes, matrix
%    fitness- fitness, vector
%    tsize- tournament size
% Output:
%    newpop- mating pool, matrix
% Copyright (c) 2008 by Prof. Gang-Gyoo Jin, Korea Maritime University
%
function newpop= TournSel(rcga,pop,fitness,tsize)

if(tsize < 2)
	tsize= 2;
elseif(tsize > rcga.popsize)
	tsize= rcga.popsize;
end
for i= 1:rcga.popsize
	mate= Pickup(rcga.popsize*ones(1,tsize));
	[fitwin,jwin]= max(fitness(mate));
	newpop(i,:)= pop(mate(jwin),:);
end
