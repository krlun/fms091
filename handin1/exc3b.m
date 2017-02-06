function [C] = exc3b(N, E, k, lambda)
%EXC3B calculates the covariance for the power production of two 
%Nordex N90-2500 LS wind turbines subject to a bivariate Weibull
%distribution modelling the wind. The values for alpha, p and q are
%hard coded into the function.

    load('powercurve_N90.mat');
    alpha = 0.638; p = 3; q = 1.5;
    
    f = @(v) wblpdf(v, lambda, k);
    F = @(v) wblcdf(v, lambda, k);
    fv1v2 = @(v1, v2) f(v1).*f(v2).*(1+alpha*(1-F(v1).^p).^(q-1).*(1- ...
        F(v2).^p).^(q-1).*(F(v1).^p.*(1+p*q)-1).*(F(v2).^p.*(1+p*q)-1));
    
    V = 30*rand(N, 2);
    W = P(V(:, 1)).*P(V(:, 2)).*fv1v2(V(:, 1), V(:, 2))*30^2;
    E2 = sum(W)/N;
    C = E2 - E^2;

end