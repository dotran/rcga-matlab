% The EVALOBJ2 function evaluates De Jong's test function 3
% function objfunc= EvalObj3(rcga,x)
% Input:                                                                                                                      %
%    rcga- rcga variable, structure
%    x- variables, matrix
% Output:                                                                                                                    %
%    objfunc- objective function value, vector
% Copyright (c) 2008 by Prof. Gang-Gyoo Jin, Korea Maritime University
%
% function objfunc= EvalObj3(rcga,x);
% 
% for i= 1:rcga.popsize
% 	objfunc(i)= x(i,1)^2+x(i,2)^2+x(i,3)^2;
% end
function objfunc= EvalObj3(rcga,x)

for i= 1:rcga.popsize
% 	objfunc(i,1)= 50-(x(i,1)^2+x(i,2)^2);
    objfunc(i,:)= schw(x(i,:));
end

function y = schw(x)
% 
% Schwefel function
% Matlab Code by A. Hedar (Nov. 23, 2005).
% The number of variables n should be adjusted below.
% The default value of n = 2.
% 
n = 2;
s = sum(-x.*sin(sqrt(abs(x))));
y = 418.9829*n+s;
% Global minima: x=(421, 421), f(x)=0