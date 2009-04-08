function newpop = mDynamic(ga,b)
% Dynamic mutation
% Input:
%   ga structure
%   b: degree of dependency on iteration number (degree of non-unifornmity)
% Output:
%   newpop
% References:
%   [1] C.Z. Janikow and Z. Michalewicz, "An experimental comparison of
%   binary and floating point representations in genetic algorithms. In:
%   Fourth International Conference on Genetic Algorithms (1991), pp. 31–36
%   [2] Z. Michalewicz, Genetic Algorithms + Data Structures = Evolution
%   Programs, Springer-Verlag (1992)

scheme = 2;
switch scheme
    case 1 % only 1 randomly selected gene of the mutated chromosome will be mutated
        for i=1:ga.popsize
            randnum = rand;
            if (randnum <= ga.pmutat)
                mutatgene = ceil(rand*ga.lchrom); % select mutated gene (element)
                multiplier = 1 - rand^((1-ga.curgen/ga.maxgen)^b); % used to compute DELTA
                binrand = round(rand);
                if (binrand == 0)
                    DELTA = (ga.upbnd(mutatgene) - ga.pop(i,mutatgene)) * multiplier;
                    ga.pop(i,mutatgene) = ga.pop(i,mutatgene) + DELTA;
                else
                    DELTA = (ga.pop(i,mutatgene) - ga.lobnd(mutatgene)) * multiplier;
                    ga.pop(i,mutatgene) = ga.pop(i,mutatgene) - DELTA;
                end
            end
        end
    case 2 % all genes of the mutated chromosome have a chance to be mutated
        for i=1:ga.popsize
            for j=1:ga.lchrom
                randnum = rand;
                if (randnum <= ga.pmutat)
                    multiplier = 1 - rand^((1-ga.curgen/ga.maxgen)^b); % used to compute DELTA
                    binrand = round(rand);
                    if (binrand == 0)
                        DELTA = (ga.upbnd(j) - ga.pop(i,j)) * multiplier;
                        ga.pop(i,j) = ga.pop(i,j) + DELTA;
                    else
                        DELTA = (ga.pop(i,j) - ga.lobnd(j)) * multiplier;
                        ga.pop(i,j) = ga.pop(i,j) - DELTA;
                    end
                end
            end
        end
end
newpop = ga.pop;
