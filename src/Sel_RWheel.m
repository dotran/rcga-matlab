function newpop = Sel_RWheel(EC)
% Roulette wheel selection
% Input:
%   EC structure
% Output:
%   newpop
% Modified: 2010.01.29

psel_vec = EC.fit/sum(EC.fit);
cum_psel_vec = cumsum(psel_vec);
newpop = zeros(EC.popsize,EC.lchrom);
for i=1:EC.popsize
    spin = rand;
    idx = 1;
    while (spin > cum_psel_vec(idx))
        idx = idx + 1;
    end
    newpop(i,:) = EC.pop(idx,:);
end
