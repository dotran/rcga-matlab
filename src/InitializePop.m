function newpop = InitializePop(ga)
% Initialize population
% Input:
%   ga tructure
% Output:
%   newpop

% rand('seed', ga.randseed);
newpop = zeros(ga.popsize,ga.lchrom);
for i=1:ga.popsize
    newpop(i,:) = ga.lobnd + (ga.upbnd-ga.lobnd).*rand(1,ga.lchrom);
end
