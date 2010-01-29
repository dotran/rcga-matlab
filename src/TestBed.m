function f = TestBed(funcID, bndrequest, x) %co the can them input la dimension (lchrom)
% Definition of objective funtions (benchmark problems)
% Input:
%   funcID: function ID
%   bndrequest: bounds request, 1: return dimension and bounds
%   x: vector of variables
% Output:
%   f: function value (bndrequest=0) and dimension + bounds (bndrequest=1)
% References:
%   [1] X. Yao, Y. Liu, and G. Lin, "Evolutionary programming made faster,"
%   IEEE Transactions on Evolutionary Computation, vol. 3, no. 2, pp.
%   82-102, 1999
%   [2] 
% Created: 2009.12.12
% Modified: 2010.01.29

switch funcID
    case 1 % Sphere model [1] (fmin=0)
        if (bndrequest==1)
            n = 30;
            bounds(1,:) = -100*ones(1,n);
            bounds(2,:) = +100*ones(1,n);
            f.dim = n;
            f.bnd = bounds;
        else
            f = sum(x.^2);
        end
    case 2 % Schwefel's problem 2.22 [1] (fmin=0)
        if (bndrequest==1)
            n = 30;
            bounds(1,:) = -100*ones(1,n);
            bounds(2,:) = +100*ones(1,n);
            f.dim = n;
            f.bnd = bounds;
        else
            f = sum(abs(x)) + prod(abs(x));
        end
    case 3 % Schwefel’s problem 1.2 [1] (fmin=0)
        if (bndrequest==1)
            n = 30;
            bounds(1,:) = -100*ones(1,n);
            bounds(2,:) = +100*ones(1,n);
            f.dim = n;
            f.bnd = bounds;
        else
            f = sum((cumsum(x)).^2);
        end
    case 4 % Schwefel's problem 2.21 [1] (fmin=0)
        if (bndrequest==1)
            n = 30;
            bounds(1,:) = -100*ones(1,n);
            bounds(2,:) = +100*ones(1,n);
            f.dim = n;
            f.bnd = bounds;
        else
            f = max(abs(x));
        end
    case 5 % Generalized Rosenbrock's function [1] (fmin=0)
        if (bndrequest==1)
            n = 30;
            bounds(1,:) = -30*ones(1,n);
            bounds(2,:) = +30*ones(1,n);
            f.dim = n;
            f.bnd = bounds;
        else
            x1=x; x2=x;
            x1(end)=[]; x2(1)=[];
            f = sum(100*(x2-x1.^2).^2 + (x1-1).^2);
        end
    case 6 % Step function [1] (fmin=0)
        if (bndrequest==1)
            n = 30;
            bounds(1,:) = -100*ones(1,n);
            bounds(2,:) = +100*ones(1,n);
            f.dim = n;
            f.bnd = bounds;
        else
            f = sum((floor(x+0.5)).^2);
        end
    case 7 % Quartic function with noise [1] (fmin=0)
        if (bndrequest==1)
            n = 30;
            bounds(1,:) = -1.28*ones(1,n);
            bounds(2,:) = +1.28*ones(1,n);
            f.dim = n;
            f.bnd = bounds;
        else
            p=1:length(x);
            % f = sum(p.*(x.^4)) + rand;
            f = sum(p.*(x.^4)) + sum(x.^2)*rand; % my proposal
        end
    case 8 % Generalized Schwefel's problem 2.26 [1] (fmin=-12569.486975)
        if (bndrequest==1)
            n = 30;
            bounds(1,:) = -500*ones(1,n);
            bounds(2,:) = +500*ones(1,n);
            f.dim = n;
            f.bnd = bounds;
        else
            f = sum(-x.*sin(sqrt(abs(x))));
        end
    case 9 % Generalized Rastrigin's function [1] (fmin=0)
        if (bndrequest==1)
            n = 30;
            bounds(1,:) = -5.12*ones(1,n);
            bounds(2,:) = +5.12*ones(1,n);
            f.dim = n;
            f.bnd = bounds;
        else
            f = sum(x.^2 - 10*cos(2*pi*x) + 10);
        end
    case 10 % Ackley's function [1] (fmin=0)
        if (bndrequest==1)
            n = 30;
            bounds(1,:) = -32*ones(1,n);
            bounds(2,:) = +32*ones(1,n);
            f.dim = n;
            f.bnd = bounds;
        else
            n = length(x);
            f = -20*exp(-0.2*sqrt(sum(x.^2)/n)) - exp(sum(cos(2*pi*x))/n) + 20 + exp(1);
        end
    case 11 % Generalized Griewank function [1] (fmin=0)
        if (bndrequest==1)
            n = 30;
            bounds(1,:) = -600*ones(1,n);
            bounds(2,:) = +600*ones(1,n);
            f.dim = n;
            f.bnd = bounds;
        else
            p = 1:length(x);
            f = sum(x.^2)/4000 - prod(cos(x./sqrt(p))) + 1;
        end
    case 12 % Generalized Penalized function 1 [1] (fmin=0)
        if (bndrequest==1)
            n = 30;
            bounds(1,:) = -50*ones(1,n);
            bounds(2,:) = +50*ones(1,n);
            f.dim = n;
            f.bnd = bounds;
        else
            n = length(x);
            y = 1 + (x+1)/4;
            y1=y; y2=y;
            y1(end)=[]; y2(1)=[];
            a=10; k=100; m=4;
            u = zeros(1,n);
            for i=1:n
                if (x(i)>a)
                    u(i) = k*(x(i)-a)^m;
                elseif (x(i)<-a)
                    u(i) = k*(-x(i)-a)^m;
                else
                    u(i) = 0;
                end
            end
            f = pi/n*(10*(sin(pi*y(1)))^2 + sum((y1-1).^2.*(1+10*(sin(pi*y2)).^2)) + (y(end)-1)^2)...
                + sum(u);
        end
    case 13 % Generalized Penalized function 2 [1] (fmin=0)
        if (bndrequest==1)
            n = 30;
            bounds(1,:) = -50*ones(1,n);
            bounds(2,:) = +50*ones(1,n);
            f.dim = n;
            f.bnd = bounds;
        else
            n = length(x);
            x1=x; x2=x;
            x1(end)=[]; x2(1)=[];
            a=5; k=100; m=4;
            u = zeros(1,n);
            for i=1:n
                if (x(i)>a)
                    u(i) = k*(x(i)-a)^m;
                elseif (x(i)<-a)
                    u(i) = k*(-x(i)-a)^m;
                else
                    u(i) = 0;
                end
            end
            f = 0.1*(10*(sin(3*pi*x(1)))^2 + sum((x1-1).^2.*(1+(sin(3*pi*x2)).^2))...
                + (x(end)-1)^2*(1+(sin(2*pi*x(end)))^2)) + sum(u);
        end
    case 14 % Shekel's Foxholes function [1] (fmin=0.998003837794450)
        if (bndrequest==1)
            n = 2;
            bounds(1,:) = -65.536*ones(1,n);
            bounds(2,:) = +65.536*ones(1,n);
            f.dim = n;
            f.bnd = bounds;
        else
            n = length(x);
            a(1,:) = [-32 -16   0  16  32 -32 -16   0  16  32 -32 -16   0  16  32 -32 -16   0  16  32 -32 -16   0  16  32];
            a(2,:) = [-32 -32 -32 -32 -32 -16 -16 -16 -16 -16   0   0   0   0   0  16  16  16  16  16  32  32  32  32  32];
            f = 0;
            for j=1:25
                s = 0;
                for i=1:n
                    s = s + (x(i)-a(i,j))^6;
                end
                f = f + (1/(j+s));
            end
            f = 1/(1/500 + f);
        end
    case 15 % Kowalik's function [1] (fmin=0.0003075)
        if (bndrequest==1)
            n = 4;
            bounds(1,:) = -5*ones(1,n);
            bounds(2,:) = +5*ones(1,n);
            f.dim = n;
            f.bnd = bounds;
        else
            a = [0.1957 0.1947 0.1735 0.1600 0.0844 0.0627 0.0456 0.0342 0.0323 0.0235 0.0246];
            b = [0.25 0.5 1 2 4 6 8 10 12 14 16].^-1;
            f = 0;
            for i=1:11
                f = f + (a(i) - (x(1)*(b(i)^2+b(i)*x(2)))/(b(i)^2+b(i)*x(3)+x(4)))^2;
            end
        end
    case 16 % Six-hump Camel-Back function [1] (fmin=-1.0316285)
        if (bndrequest==1)
            n = 2;
            bounds(1,:) = -5*ones(1,n);
            bounds(2,:) = +5*ones(1,n);
            f.dim = n;
            f.bnd = bounds;
        else
            f = 4*x(1)^2 - 2.1*x(1)^4 + x(1)^6/3 + x(1)*x(2) - 4*x(2)^2 + 4*x(2)^4;
        end
    case 17 % Branin function [1] (fmin=0.39788736)
        if (bndrequest==1)
            n = 2;
            bounds(1,:) = [-5 0];
            bounds(2,:) = [10 15];
            f.dim = n;
            f.bnd = bounds;
        else
            f = (x(2)-5.1*x(1)^2/(4*pi*pi)+5*x(1)/pi-6)^2 + 10*(1-1/(8*pi))*cos(x(1)) + 10;
        end
    case 18 % Goldstein-Price function [1] (fmin=3)
        if (bndrequest==1)
            n = 2;
            bounds(1,:) = -2*ones(1,n);
            bounds(2,:) = +2*ones(1,n);
            f.dim = n;
            f.bnd = bounds;
        else
            f = (1 + (x(1)+x(2)+1)^2*(19-14*x(1)+3*x(1)^2-14*x(2)+6*x(1)*x(2)+3*x(2)^2)) * ...
                (30 + (2*x(1)-3*x(2))^2*(18-32*x(1)+12*x(1)^2+48*x(2)-36*x(1)*x(2)+27*x(2)^2));
        end
    case 19 % Hartman's family: function 1 (n=3) [1] (fmin=-3.8627821)
        if (bndrequest==1)
            n = 3;
            bounds(1,:) = 0*ones(1,n);
            bounds(2,:) = 1*ones(1,n);
            f.dim = n;
            f.bnd = bounds;
        else
            n = 3;
            a = [3 10 30; 0.1 10 35; 3 10 30; 0.1 10 35];
            c = [1 1.2 3 3.2];
            p = [0.3689 0.1170 0.2673; 0.4699 0.4387 0.7470; 0.1091 0.8732 0.5547; 0.03815 0.5743 0.8828];
            si = 0;
            for i=1:4
                sj = 0;
                for j=1:n
                    sj = sj + a(i,j)*(x(j)-p(i,j)).^2;
                end
                si = si + c(i)*exp(-sj);
            end
            f = -si;
        end
	case 20 % Hartman's family: function 2 (n=6) [1] (fmin=-3.32)
        if (bndrequest==1)
            n = 6;
            bounds(1,:) = 0*ones(1,n);
            bounds(2,:) = 1*ones(1,n);
            f.dim = n;
            f.bnd = bounds;
        else
            n = 6;
            a = [10 3 17 3.5 1.7 8; 0.05 10 17 0.1 8 14; 3 3.5 1.7 10 17 8; 17 8 0.05 10 0.1 14];
            c = [1 1.2 3 3.2];
            p = [0.1312 0.1696 0.5569 0.0124 0.8283 0.5886;...
                 0.2329 0.4135 0.8307 0.3736 0.1004 0.9991;...
                 0.2348 0.1415 0.3522 0.2883 0.3047 0.6650;...
                 0.4047 0.8828 0.8732 0.5743 0.1091 0.0381];
            si = 0;
            for i=1:4
                sj = 0;
                for j=1:n
                    sj = sj + a(i,j)*(x(j)-p(i,j)).^2;
                end
                si = si + c(i)*exp(-sj);
            end
            f = -si;
        end
    case {21, 22, 23} % Shekel's family (m = 5, 7, 10 local minima) [1]
        if (bndrequest==1)
            n = 4;
            bounds(1,:) = 0*ones(1,n);
            bounds(2,:) = 10*ones(1,n);
            f.dim = n;
            f.bnd = bounds;
        else
            a = [4 4 4 4;...
                 1 1 1 1;...
                 8 8 8 8;...
                 6 6 6 6;...
                 3 7 3 7;...
                 2 9 2 9;...
                 5 5 3 3;...
                 8 1 8 1;...
                 6 2 6 2;...
                 7 3.6 7 3.6];
            c = [0.1 0.2 0.2 0.4 0.4 0.6 0.3 0.7 0.5 0.5];
            if (funcID==21) % (fmin=-10.331532035585971)
                m = 5; % number of local minima
            elseif (funcID==22) % (fmin=-10.624248140533481)
                m = 7;
            else % (fmin=-10.727712973784634)
                m = 10;
            end
            s = 0;
            for i=1:m
                s = s + 1/((x-a(i))*(x-a(i))' + c(i));
            end
            f = -s;
        end
end
























