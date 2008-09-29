% The RREPPOP function presents a population  report
% function rRepPop(rcga,pop,objfunc,fitness,opts)
% Input:
%    rcga- rcga variable, structure
%    pop- population
%    objfunc- objective function value
%    fitness- fitness value
%    opts- options for the report(1~2)
% Copyright (c) 2008 by Prof. Gang-Gyoo Jin, Korea Maritime University
%
function rRepPop(rcga,pop,objfunc,fitness,opts)

for i= 1:rcga.popsize
	fprintf('%3d) ',i);
	for j= 1:rcga.lchrom
		fprintf('%8.3f ',pop(i,j));
	end
	if(opts >= 2)
		fprintf('  %8.3f  %8.3f',objfunc(i),fitness(i));
	end
	fprintf('\n');
end
fprintf('\n');
	
