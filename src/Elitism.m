function [newpop, newobj, newfit] = Elitism(EC)
% Elitist selection (also called elitist strategy or elitism)
% Input:
%   EC structure
% Output:
%   newpop
% Created: 2009.12.10
% Modified: 2010.01.29

scheme = 2; % Performance 2 > 1
newpop = EC.pop;
newobj = EC.obj;
newfit = EC.fit;
switch scheme
    case 1
        % Only copy best individual(s) to the latter generation when the
        % fittest individual of the latter generation is worse than the elitist
        if (EC.probtype == 1) % maximization problem
            oldbestobj = EC.stat.bestobj; % statistical result of last generation
            newbestobj = max(EC.obj); % the best individual of current generation
            if (oldbestobj > newbestobj)
                [newworstobj, newworstindex] = min(EC.obj);
                newpop(newworstindex,:) = EC.stat.bestchrom;
                newobj(newworstindex) = EC.stat.bestobj;
                newfit(newworstindex) = EC.stat.bestfit;
            end
        else % minimization problem
            oldbestobj = EC.stat.bestobj; % statistical result of last generation
            newbestobj = min(EC.obj); % the best individual of current generation
            if (oldbestobj < newbestobj)
                [newworstobj, newworstindex] = max(EC.obj);
                newpop(newworstindex,:) = ECC.stat.bestchrom;
                newobj(newworstindex) = EC.stat.bestobj;
                newfit(newworstindex) = EC.stat.bestfit;
            end
        end
    case 2
        % Always copy best individual(s) to the latter generation
        if (EC.probtype == 1) % maximization problem
            [newworstobj, newworstindex] = min(EC.obj);
            newpop(newworstindex,:) = EC.stat.bestchrom;
            newobj(newworstindex) = EC.stat.bestobj;
            newfit(newworstindex) = EC.stat.bestfit;
        else % minimization problem
            [newworstobj, newworstindex] = max(EC.obj);
            newpop(newworstindex,:) = EC.stat.bestchrom;
            newobj(newworstindex) = EC.stat.bestobj;
            newfit(newworstindex) = EC.stat.bestfit;
        end
end
