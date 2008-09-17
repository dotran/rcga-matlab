% The RINITPA2 function initializes the parameters of a RCGA
% function rcga= rInitPa2
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
function rcga= rInitPa2

rcga.rseed=		2712; 
rcga.maxmin=      -1;            % -1 for minimization
rcga.maxgen=	 300;
rcga.popsize=    20;             % popsize should be even
rcga.lchrom=	   2;
rcga.pcross=	 1.0;
rcga.pmutat=	 0.5;
%rcga.xlb=	-2.048*ones(1,rcga.lchrom);
%rcga.xub= 2.047*ones(1,rcga.lchrom);
rcga.xlb=	-500.0*ones(1,rcga.lchrom);
rcga.xub= 500.0*ones(1,rcga.lchrom);
%rcga.xlb=	-10.0*ones(1,rcga.lchrom);
%rcga.xub= 10.0*ones(1,rcga.lchrom);

if(rem(rcga.popsize, 2) ~= 0) % do not move
	rcga.popsize= rcga.popsize + 1;
end

