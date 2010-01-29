function newpop = InitializePop(EC)
% Initialize population
% Input:
%   EC structure
% Output:
%   newpop
% Created: 2009.12.10
% Modified: 2010.01.29

% rand('seed', EC.randseed);
newpop = zeros(EC.popsize,EC.lchrom);
for i=1:EC.popsize
    newpop(i,:) = EC.lobnd + (EC.upbnd-EC.lobnd).*rand(1,EC.lchrom);
end
