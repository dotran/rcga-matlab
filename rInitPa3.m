%*************************************************************************%
% The RINITPA3 function initializes the parameters of a RCGA                                   %
%                                                                                                                                %
% function [rseed,maxmin,maxgen,popsize,lchrom,pcross,pmutat,xlb,xub,etha]...  %
%                     = rInitPa5                                                                                            %
% Output:                                                                                                                    %
%    rseed-	random seed                                                                                          %
%    maxmin= -1 for minimization, 1 for maximization                                                   %
%    maxgen-	maximum generation                                                                           %
%    popsize- population size(must be an even integer)                                             %
%    lchrom- chromosome length                                                                               %
%    pcross- crossover probability                                                                             %
%    pmutat- mutation probability                                                                                 %
%    xlb- lower bound  of variables                                                                             %
%    xub- upper bound of variables                                                                            %
%    etha- parameter of the selection operator                                                           %
%                                                                                                                                %
% Copyright (c) 2000 by Prof. Gang-Gyoo Jin, Korea Maritime University                   % 
%*************************************************************************%
function [rseed,maxmin,maxgen,popsize,lchrom,pcross,pmutat,xlb,xub,etha]= rInitPa3

rseed=		 3910; 
maxmin=      -1;            % -1 for minimization
maxgen=	 300;
popsize=    20;             % popsize should be even
lchrom=		    3;
etha=         1.8;
pcross=		 1.0;
pmutat=	    0.1;
xlb=	-65.536*ones(1,lchrom);
xub= 65.535*ones(1,lchrom);

if(rem(popsize, 2) ~= 0) % do not move
	popsize= popsize + 1;
end