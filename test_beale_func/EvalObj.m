% The EVALOBJ function
% function objfunc= EvalObj(rcga,x)
% Input:                                                                                                                      %
%    rcga- rcga variable, structure
%    x- variables, matrix
% Output:                                                                                                                    %
%    objfunc- objective function value, vector
% Copyright (c) 2008 by Prof. Gang-Gyoo Jin, Korea Maritime University
%
function objfunc= EvalObj(rcga,x)

for i= 1:rcga.popsize
% 	objfunc(i,1)= 50-(x(i,1)^2+x(i,2)^2);
    objfunc(i,1)= beale(x(i,:));
end

function y = beale(x)
% 
% Beale function.
% Matlab Code by A. Hedar (Sep. 29, 2005).
% The number of variables n = 2.
% 
y = (1.5-x(1)*(1-x(2)))^2+(2.25-x(1)*(1-x(2)^2))^2+(2.625-x(1)*(1-x(2)^3))^2;