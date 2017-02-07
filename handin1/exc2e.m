function [INormalized] = exc2e(k, lambda, rho, d, I)
%EXC2E calculates a normalised interval for the expected possible ratio of
%power production, normalizing against the total amount of power in the
%wind.

    alpha = rho*pi*d^2*k/(8*lambda^k);
    a = 3/k + 1; b = lambda^k;
    EPTot = alpha/k*gamma(a)*b^a;
    
    INormalized = I./EPTot;

end