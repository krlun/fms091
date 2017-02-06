function [INormalized] = exc2e(k, lambda, rho, d, I)
%EXC2E Summary of this function goes here
%   Detailed explanation goes here

    alpha = rho*pi*d^2*k/(8*lambda^k);
    a = 3/k + 1; b = lambda^k;
    EPTot = alpha/k*gamma(a)*b^a;
    
    INormalized = I./EPTot;

end