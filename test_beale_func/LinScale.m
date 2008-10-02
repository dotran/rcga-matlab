% The LINSCALE function maps raw fitness into linearly scaled fitness
% function scalefit= LinScale(rawfit,sfactor)
% Input:
%    rawfit- raw fitness
%    sfactor- scaling factor(1.2~2)
% Output:
%    scalefit- linearly scaled fitness
% Copyright (c) 2000 by Prof. Gang-Gyoo Jin, Korea Maritime University
%
function scalefit= LinScale(rawfit, sfactor)

fitmin= min(rawfit);
fitmax= max(rawfit);
fitavg= mean(rawfit);
if(fitmax-fitmin < 0.001)
  scalefit= rawfit;
  return;
end

if(fitmin >= (sfactor*fitavg-fitmax)/(sfactor-1))
  delta= fitmax - fitavg;
  if (delta < 0.001)
    delta= 0.001;
  end
  a= (sfactor-1)*fitavg/delta;
  b= fitavg*(fitmax-sfactor*fitavg)/delta;
else
  delta= fitavg-fitmin;
  if(delta < 0.001)
    delta= 0.001;
  end
  a= fitavg/delta;
  b= -fitmin*fitavg/delta;
end
scalefit= a*rawfit+b;
