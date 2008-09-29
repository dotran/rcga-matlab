%*************************************************************************%
% The SELECT function selects a population using the remainder method                %
%                                                                                                                               %
% function newpop=Select(pop,popsize,idxchrom)                                                   %
% Input:                                                                                                                      %
%    pop- population of chromosomes, matrix                                                            %
%    popsize- population size                                                                                     %
%    idxchrom- index of selected chromesomes, vector                                             %
% Output:                                                                                                                    %
%    newpop- selected population, matrix                                                                   %
%                                                                                                                                %
% Copyright (c) 2000 by Prof. Gang-Gyoo Jin, Korea Maritime University                    % 
%*************************************************************************%
function newpop=Select(pop,popsize,idxchrom)

n= popsize;
for i= 1:popsize
	npick= Pickup(n);
	sel= idxchrom(npick);
	newpop(i,:)= pop(sel,:);
	idxchrom(npick)= idxchrom(n);
	n=n-1;
end
