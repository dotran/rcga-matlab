function [newpop, newobj, newfit] = Elitism(ga)
% Elitist selection (also called elitist strategy or elitism)
% Input:
%   ga structure
% Output:
%   newpop

scheme = 2; % Performance 2 > 1
newpop = ga.pop;
newobj = ga.obj;
newfit = ga.fit;
switch scheme
    case 1
        % Only copy best individual(s) to the latter generation when the
        % fittest individual of the latter generation is worse than the elitist
        if (ga.probtype == 1) % maximization problem
            oldbestobj = ga.stat.bestobj; % statistical result of last generation
            newbestobj = max(ga.obj); % the best individual of current generation
            if (oldbestobj > newbestobj)
                [newworstobj, newworstindex] = min(ga.obj);
                newpop(newworstindex,:) = ga.stat.bestchrom;
                newobj(newworstindex) = ga.stat.bestobj;
                newfit(newworstindex) = ga.stat.bestfit;
            end
        else % minimization problem
            oldbestobj = ga.stat.bestobj; % statistical result of last generation
            newbestobj = min(ga.obj); % the best individual of current generation
            if (oldbestobj < newbestobj)
                [newworstobj, newworstindex] = max(ga.obj);
                newpop(newworstindex,:) = ga.stat.bestchrom;
                newobj(newworstindex) = ga.stat.bestobj;
                newfit(newworstindex) = ga.stat.bestfit;
            end
        end
    case 2
        % Always copy best individual(s) to the latter generation
        if (ga.probtype == 1) % maximization problem
            [newworstobj, newworstindex] = min(ga.obj);
            newpop(newworstindex,:) = ga.stat.bestchrom;
            newobj(newworstindex) = ga.stat.bestobj;
            newfit(newworstindex) = ga.stat.bestfit;
        else % minimization problem
            [newworstobj, newworstindex] = max(ga.obj);
            newpop(newworstindex,:) = ga.stat.bestchrom;
            newobj(newworstindex) = ga.stat.bestobj;
            newfit(newworstindex) = ga.stat.bestfit;
        end
end
