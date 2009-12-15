function PlotTestBed
% Plot
% Input:
%   ga structure
% Output:
%   newpop
% Modified: 2009-12-15

funcID = 14;
funcinfo = TestBed(funcID, 1, 0);
x1lobnd = funcinfo.bnd(1,1);
x1upbnd = funcinfo.bnd(2,1);
x2lobnd = funcinfo.bnd(1,2);
x2upbnd = funcinfo.bnd(2,2);
stepnum = 75;
x1 = x1lobnd:(x1upbnd-x1lobnd)/stepnum:x1upbnd;
x2 = x2lobnd:(x2upbnd-x2lobnd)/stepnum:x2upbnd;
x1=-50:0.5:50; x2=x1;
[X1,X2] = meshgrid(x1,x2);
F = zeros(length(x1),length(x1));
for i=1:length(x1)
    for j=1:length(x2)
        X = [X1(i,j) X2(i,j)];
        F(i,j) = TestBed(funcID,0,X);
    end
end
meshc(X1,X2,F)
axis tight
% fmin = min(min(F));
% fmax = max(max(F));
% fmaxexcess = 0.2*(fmax-fmin);
% axis([x1lobnd x1upbnd x2lobnd x2upbnd fmin round(fmax+fmaxexcess)])
% set(gca,'FontName','Helvetica','FontSize',12);
% set(gca,'XLim',[x1lobnd x1upbnd],'XTick',[x1lobnd (x1upbnd+x1lobnd)/2 x1upbnd]);
% set(gca,'YLim',[x2lobnd x2upbnd],'YTick',[x2lobnd (x2upbnd+x2lobnd)/2 x2upbnd]);
% set(gca,'ZLim',[fmin (fmax+fmaxexcess)],'ZTick',[fmin fmax round(fmax+fmaxexcess)]);
