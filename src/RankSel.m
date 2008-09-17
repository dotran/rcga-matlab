%*************************************************************************%
% The RANKSEL function performs rank-based selection                                          %
%                                                                                                                                %
% function newpop= RankSel(pop,popsize,fitness,rfactor)                                         %
% Input:                                                                                                                      %
%    pop- population of chromosomes, matrix                                                            %
%    popsize- population size                                                                                     %
%    fitness- fitness of chromesomes, vector                                                              %
%    rfactor- factor for ranking-based scaling(1.1~2)                                                 %
% Output:                                                                                                                    %
%    newpop- mating pool, matrix                                                                                %
%                                                                                                                                %
% Copyright (c) 2000 by Prof. Gang-Gyoo Jin, Korea Maritime University                    % 
%*************************************************************************%
function newpop= RankSel(pop,popsize,fitness,rfactor)

fitsum= sum(fitness);
if(fitsum ~= 0)
  if(rfactor < 1.1)
    rfactor= 1.1;
  elseif(rfactor > 2)
    rfactor= 2;
  end
  [fit,rank]= sort(fitness);
  for i=1:popsize
    j= popsize-i+1;
    expect(rank(i))= rfactor-2*(rfactor-1)*(j-1)/(popsize-1);
  end
  cumpexp= cumsum(expect);

  pt= rand;
  for i= 1:popsize
    for nsel= 1:popsize
      if(pt < cumpexp(nsel))
        idxchrom(i)= nsel;
        break;
      end
    end
    pt= pt+1;
  end

else
  idxchrom= [1:popsize];
end
newpop= Select(pop,popsize,idxchrom);
