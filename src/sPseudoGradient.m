function [newpop, gp] = sPseudoGradient(ga,gp)
% Pseudo-gradient reproduction operator
% Input:
%   ga structure
%   eta: positive coefficient
% Output:
%   newpop
% References:
%   [1] J. Y. Wen, Q. H. Wu, L. Jiang, and S. J. Cheng, "Pseudo-gradient
%   based evolutionary programming," Electronics Letters, vol. 39, no. 7,
%   pp. 631-632, 2003
% Modified: 2009-12-15

beta1 = 5;
beta2 = 0.05;
beta = (beta2-beta1)*ga.curgen/ga.maxgen + 5;
sigma = beta*ga.fit/sum(ga.fit);

for i=1:ga.popsize
    if (gp(i,end)==0)
        newchrom(i) = ga.pop(i,:) + sigma(i)*randn(1,ga.lchrom);
    else
        newchrom(i) = ga.pop(i,:) + gp(i,:).*abs(sigma(i)*randn(1,ga.lchrom));
    end
end
