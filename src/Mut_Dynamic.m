function newpop = Mut_Dynamic(EC,b)
% Dynamic mutation
% Input:
%   EC structure
%   b: degree of dependency on iteration number (degree of non-unifornmity)
% Output:
%   newpop
% References:
%   [1] C.Z. Janikow and Z. Michalewicz, "An experimental comparison of
%   binary and floating point representations in genetic algorithms. In:
%   Fourth International Conference on Genetic Algorithms (1991), pp. 31–36
%   [2] Z. Michalewicz, Genetic Algorithms + Data Structures = Evolution
%   Programs, Springer-Verlag (1992)
% Created: 2009.12.11
% Modified: 2010.01.29

scheme = 2;
switch scheme
    case 1 % only 1 randomly selected gene of the mutated chromosome will be mutated
        for i=1:EC.popsize
            randnum = rand;
            if (randnum <= EC.pmutat)
                mutatgene = ceil(rand*EC.lchrom); % select mutated gene (element)
                multiplier = 1 - rand^((1-EC.curgen/EC.maxgen)^b); % used to compute DELTA
                binrand = round(rand);
                if (binrand == 0)
                    DELTA = (EC.upbnd(mutatgene) - EC.pop(i,mutatgene)) * multiplier;
                    EC.pop(i,mutatgene) = EC.pop(i,mutatgene) + DELTA;
                else
                    DELTA = (ga.pop(i,mutatgene) - EC.lobnd(mutatgene)) * multiplier;
                    EC.pop(i,mutatgene) = EC.pop(i,mutatgene) - DELTA;
                end
            end
        end
    case 2 % all genes of the mutated chromosome have a chance to be mutated
        for i=1:EC.popsize
            for j=1:EC.lchrom
                randnum = rand;
                if (randnum <= EC.pmutat)
                    multiplier = 1 - rand^((1-EC.curgen/EC.maxgen)^b); % used to compute DELTA
                    binrand = round(rand);
                    if (binrand == 0)
                        DELTA = (EC.upbnd(j) - EC.pop(i,j)) * multiplier;
                        EC.pop(i,j) = EC.pop(i,j) + DELTA;
                    else
                        DELTA = (EC.pop(i,j) - EC.lobnd(j)) * multiplier;
                        EC.pop(i,j) = EC.pop(i,j) - DELTA;
                    end
                end
            end
        end
end
newpop = EC.pop;
