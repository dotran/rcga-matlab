function newpop = xArithmetic(ga)
% Arithmetic crossover
% Input:
%   ga structure
% Output:
%   newpop

scheme = 5; % Performance 5 > 3 > 4 > 1 > 2
newpop = ga.pop;
switch scheme
    case 1 % All genes use the same value of lambda
        % Each individual can only undergo crossover 1 time
        % Number of offspring = number of parents
        indivIDvec = (1:ga.popsize)'; % store IDs of all individuals in the population
        randvec = rand(ga.popsize,1);
        i = 0;
        count = ga.popsize;
        while (count > 1) % skip crossover if there is only 1 individual left in population
            i = i + 1;
            if (randvec(1) <= ga.pcross)
                randvec(1) = [];
                parent1ID = indivIDvec(i); % identify parent1 in the population
                parent1chrom = ga.pop(parent1ID,:);
                indivIDvec(i) = []; % delete the crossover individual from the ID list
                i = i - 1;
                parent2pos = ceil(rand*length(indivIDvec)); % positioning the mate (sexual partner)
                parent2ID = indivIDvec(parent2pos); % identify parent2 in the population
                parent2chrom = ga.pop(parent2ID,:);
                indivIDvec(parent2pos) = [];
                randvec(1) = [];
                count = count - 2;
                % Perform crossover operator on the two selected chromosomes
                lambda = rand;
                child1chrom = lambda*parent1chrom + (1-lambda)*parent2chrom;
                child2chrom = (1-lambda)*parent1chrom + lambda*parent2chrom;
                % Recombinants replace parents
                newpop(parent1ID,:) = child1chrom;
                newpop(parent2ID,:) = child2chrom;
            else
                randvec(1) = [];
                count = count - 1;
            end
        end
    case 2 % All genes use the same value of lambda
        % Each individual can independently choose its mate
        % ==> it may undergo crossover multiple times
        % Number of offspring = 2 * number of parents
        randvec = rand(ga.popsize,1);
        for i=1:ga.popsize
            if (randvec(i) <= ga.pcross)
                parent1ID = i; % identify parent1 in the population
                parent1chrom = ga.pop(parent1ID,:);
                parent2ID = ceil(rand*ga.popsize); % positioning the mate (sexual partner)
                if (parent2ID == parent1ID)
                    if (i == ga.popsize)
                        parent2ID = 1;
                    else
                        parent2ID = parent1ID + 1;
                    end
                end
                parent2chrom = ga.pop(parent2ID,:);
                % Perform crossover operator on the two selected chromosomes
                lambda = rand;
                child1chrom = lambda*parent1chrom + (1-lambda)*parent2chrom;
                child2chrom = (1-lambda)*parent1chrom + lambda*parent2chrom;
                % Recombinants replace parents
                newpop(parent1ID,:) = child1chrom;
                newpop(parent2ID,:) = child2chrom;
            end
        end
    case 3 % Each gene uses its own random value of lambda
        % Each individual can only undergo crossover 1 time
        % Number of offspring = number of parents
        indivIDvec = (1:ga.popsize)'; % store IDs of all individuals in the population
        randvec = rand(ga.popsize,1);
        i = 0;
        count = ga.popsize;
        while (count > 1) % skip crossover if there is only 1 individual left in population
            i = i + 1;
            if (randvec(1) <= ga.pcross)
                randvec(1) = [];
                parent1ID = indivIDvec(i); % identify parent1 in the population
                parent1chrom = ga.pop(parent1ID,:);
                indivIDvec(i) = []; % delete the crossover individual from the ID list
                i = i - 1;
                parent2pos = ceil(rand*length(indivIDvec)); % positioning the mate (sexual partner)
                parent2ID = indivIDvec(parent2pos); % identify parent2 in the population
                parent2chrom = ga.pop(parent2ID,:);
                indivIDvec(parent2pos) = [];
                randvec(1) = [];
                count = count - 2;
                % Perform crossover operator on the two selected chromosomes
                lambdavec = rand(1,ga.lchrom);
                child1chrom = lambdavec.*parent1chrom + (1-lambdavec).*parent2chrom;
                child2chrom = (1-lambdavec).*parent1chrom + lambdavec.*parent2chrom;
                % Recombinants replace parents
                newpop(parent1ID,:) = child1chrom;
                newpop(parent2ID,:) = child2chrom;
            else
                randvec(1) = [];
                count = count - 1;
            end
        end
    case 4 % Each gene uses its own random value of lambda
        % Each individual can independently choose its mate
        % ==> it may undergo crossover multiple times
        % Number of offspring = 2 * number of parents
        randvec = rand(ga.popsize,1);
        for i=1:ga.popsize
            if (randvec(i) <= ga.pcross)
                parent1ID = i; % identify parent1 in the population
                parent1chrom = ga.pop(parent1ID,:);
                parent2ID = ceil(rand*ga.popsize); % positioning the mate (sexual partner)
                if (parent2ID == parent1ID)
                    if (i == ga.popsize)
                        parent2ID = 1;
                    else
                        parent2ID = parent1ID + 1;
                    end
                end
                parent2chrom = ga.pop(parent2ID,:);
                % Perform crossover operator on the two selected chromosomes
                lambdavec = rand(1,ga.lchrom);
                child1chrom = lambdavec.*parent1chrom + (1-lambdavec).*parent2chrom;
                child2chrom = (1-lambdavec).*parent1chrom + lambdavec.*parent2chrom;
                % Recombinants replace parents
                newpop(parent1ID,:) = child1chrom;
                newpop(parent2ID,:) = child2chrom;
            end
        end
    case 5 % Each gene uses its own random value of lambda; Individuals are coupled first, then randomly decide whether offspring will be create
        for i=1:(ga.popsize/2)
            randnum = rand;
            if (randnum < ga.pcross)
                % Identify parent chromosomes
                parent1ID = 2*i - 1;
                parent2ID = 2*i;
                parent1chrom = ga.pop(parent1ID,:);
                parent2chrom = ga.pop(parent2ID,:);
                % Perform crossover operator on the two selected chromosomes
                lambdavec = rand(1,ga.lchrom);
                child1chrom = lambdavec.*parent1chrom + (1-lambdavec).*parent2chrom;
                child2chrom = (1-lambdavec).*parent1chrom + lambdavec.*parent2chrom;
                % Recombinants replace parents
                newpop(parent1ID,:) = child1chrom;
                newpop(parent2ID,:) = child2chrom;
            end
        end
end
