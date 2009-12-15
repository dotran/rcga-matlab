function newpop = PopMixing(ga)
% Mixing the population
% Input:
%   ga tructure
% Output:
%   newpop
% Modified: 2009-12-15

newpop = zeros(ga.popsize,ga.lchrom);
popbuf = ga.pop;
for i=1:(ga.popsize-1)
    randnum = floor(rand*(ga.popsize-i+1)) + 1; % randnum decreases from 50 to 1
    newpop(i,:) = popbuf(randnum,:);
    popbuf(randnum,:) = []; % remove the selected chromosome
end
newpop(ga.popsize,:) = popbuf(1,:); % the last chromosome
