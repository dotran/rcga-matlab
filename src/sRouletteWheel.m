function newpop = sRouletteWheel(ga)
% Roulette wheel selection
% Input:
%   ga tructure
% Output:
%   newpop
% Modified: 2009-12-15

psel_vec = ga.fit/sum(ga.fit);
cum_psel_vec = cumsum(psel_vec);
newpop = zeros(ga.popsize,ga.lchrom);
for i=1:ga.popsize
    spin = rand;
    idx = 1;
    while (spin > cum_psel_vec(idx))
        idx = idx + 1;
    end
    newpop(i,:) = ga.pop(idx,:);
end
