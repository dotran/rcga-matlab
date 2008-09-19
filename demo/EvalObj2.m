% The EVALOBJ2 function
% function objfunc= EvalObj2(rcga,x)
% Input:                                                                                                                      %
%    rcga- rcga variable, structure
%    x- variables, matrix
% Output:                                                                                                                    %
%    objfunc- objective function value, vector
% Copyright (c) 2008 by Prof. Gang-Gyoo Jin, Korea Maritime University
%
function objfunc= EvalObj2(rcga,x);

for i= 1:rcga.popsize
	objfunc(i,1)= 50-(x(i,1)^2+x(i,2)^2);
end
