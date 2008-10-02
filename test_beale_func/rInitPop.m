% The RINITPOP function creates an initial population 
% function pop= rInitPop(rcga)
% Input:                                                                                                                      %
%    rcga- rcga variable, structure
% Output:                                                                                                                    %
%    pop- population                                                                                                   %
% Copyright (c) 2008 by Prof. Gang-Gyoo Jin, Korea Maritime University
%
function pop= rInitPop(rcga)

rand('seed',rcga.rseed);
pop= zeros(rcga.popsize,rcga.lchrom);
for i=1:rcga.popsize
  pop(i,:)= (rcga.xub-rcga.xlb).*rand(1,rcga.lchrom)+rcga.xlb;
end