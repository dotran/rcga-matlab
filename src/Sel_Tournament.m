function newpop = Sel_Tournament(EC, tsize)
% Tournament selection
% Input:
%   EC structure
% Output:
%   newpop
% References:
%   [1] A. Sokolov and D. Whitley, “Unbiased tournament selection,” in 
%   Proceedings of the 2005 conference on Genetic and evolutionary 
%   computation, Washington DC, USA, 2005, pp. 1131-1138.
% Created: 2010.03.24
% Modified: 2010.03.24

newpop = zeros(EC.popsize,EC.lchrom);
if (tsize < 2)
    tsize = 2; % tournament size must be at least 2
elseif(tsize > EC.popsize)
    tsize = EC.popsize;
end
for i=1:EC.popsize
    mate = PickUp(EC.popsize * ones(1,tsize));
    [fitwin,idxwin] = max(EC.fit(mate));
    newpop(i,:)= EC.pop(mate(idxwin),:);
end

function picknum = PickUp(num)
% PickUp function picks up an integer random number between 1 and num
% Input:
%   num: scalar value OR vector OR matrix with values >= 1
% Output:
%   picknum: each element is an integer value from 1 to that respective
%            value in num
if min(num) < 1
  disp('num is less than one!')
  return;
end
fr = rand(size(num));
picknum = floor(fr.*num) + 1;

