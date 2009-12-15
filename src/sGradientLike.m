function newpop = sGradientLike(ga,eta)
% Gradient-like reproduction operator
% Input:
%   ga structure
%   eta: positive coefficient
% Output:
%   newpop
% References:
%   [1] D. T. Pham and G. Jin, "Genetic algorithm using gradient-like
%   reproduction operator," Electronics Letters, vol. 31, no. 18, pp.
%   1558-1559, 1995
% Modified: 2009-12-15

bndrange = min(ga.upbnd-ga.lobnd);
bestfit = ga.stat.bestfit;
bestchrom = ga.pop(ga.stat.bestindex,:);
for i=1:ga.popsize
    chrom = ga.pop(i,:);
    dist2best = norm(chrom-bestchrom);
    norfitdif = (bestfit-ga.fit(i))/bestfit;
    paramdif = bestchrom - chrom;
%     if (abs(eta*norfitdif-1) < 10^-2) % co 2 cases: (1) x(i) va xb o xa,
%     rand nen lon hon 0.5; (2) neu o gan thi fitness chenh lech it se tao
%     nen vi tri moi la random giu vtri cu va best chrom nen cung OK
    if (abs(eta*norfitdif-1)/(dist2best/bndrange) < 10^-2) % not permitted
        newchrom = chrom + rand*paramdif; % to locate near the best chromosome
    else
        newchrom = chrom + eta*norfitdif*paramdif;
    end
    for j=1:ga.lchrom
        if (newchrom(j)<ga.lobnd(j))
            newchrom(j) = bestchrom(j) + rand*(ga.lobnd(j)-bestchrom(j));
        end
        if (newchrom(j)>ga.upbnd(j))
            newchrom(j) = bestchrom(j) + rand*(ga.upbnd(j)-bestchrom(j));
        end
    end
    ga.pop(i,:) = newchrom;
end
newpop = ga.pop;

