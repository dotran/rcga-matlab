% The RINITPA function initializes the parameters of a RCGA
% function rcga= rInitPa
% Output:
%    rcga- rcga variable, structure
%    rseed-	random seed
%    maxmin= -1 for minimization, 1 for maximization
%    maxgen-	maximum generation
%    popsize- population size(must be an even integer)
%    lchrom- chromosome length
%    etha- parameter of the selection operator
%    pcross- crossover probability
%    pmutat- mutation probability
%    xlb- lower bound  of variables
%    xub- upper bound of variables

% Copyright (c) 2008 by Prof. Gang-Gyoo Jin, Korea Maritime University 
%
function rcga= rInitPa
rcga.maxmin=      -1;            % -1 for minimization
rcga.rseed=		35712; 
rcga.maxgen=	 100000;
rcga.popsize=     20;             % popsize should be even
rcga.lchrom=	   2;
rcga.pcross=	 0.9;
rcga.pmutat=	 0.02;
rcga.xlb= -500.0*ones(1,rcga.lchrom);
rcga.xub= 500.0*ones(1,rcga.lchrom);

% Default values of the variables
rcga.chrombest=	 zeros(1,rcga.lchrom);
rcga.objbest=      0;
rcga.fitbest=      0;
if rcga.maxmin == 1
    rcga.objsofarbest= -1e30;
else
    rcga.objsofarbest= 1e30;
end
rcga.gam=          0;
rcga.chromsofarbest= zeros(1,rcga.lchrom);
rcga.fitsofarbest= 0;
rcga.objave=       0;
if(rem(rcga.popsize, 2) ~= 0)
	rcga.popsize= rcga.popsize + 1;
end

