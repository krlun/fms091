function [VPXPY, SPXPY] = exc3c(N, E, C, k, lambda)
%EXC3C calculates the variance for the power production of two 
%Nordex N90-2500 LS wind turbines subject to a bivariate Weibull
%distribution modelling the wind.

% V(P[X] + P[Y]) = V(P[X]) + V(P[Y]) + 2*cov(P[X], P[Y])
% cov(P[X], P[Y]) is assumed to be C and thus supplied,
% need V(P[X]) = V(P[Y])
% V(P[X]) = E[P[X]^2] - E[P[X]]^2

    load('powercurve_N90.mat');

    MC = gamrnd(12, 1, 1, N);
    MCEst = (P(MC)'.^2).*wblpdf(MC, lambda, k)./gampdf(MC, 12, 1);
    tau = sum(MCEst)/N;

    V = tau - E^2;
    VPXPY = 2*V+2*C;
    SPXPY = sqrt(VPXPY);

end