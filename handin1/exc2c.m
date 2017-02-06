function [IAS] = exc2c(N, lambda, k, lambdap)
%EXC2C uses antithetic sampling to reduce the variance in calculating
%the a confidence interval for the estimated power output of a
%Nordex N90-2500 LS wind turbine, where the wind is modelled using a
%Weibull distribution.

    load('powercurve_N90.mat');

    X = rand(1, N);
    Y = 1 - X;
    MC1 = P(wblinv(X, lambda, k));
    MC2 = P(wblinv(Y, lambda, k));
    W = (MC1 + MC2)/2;
    tauAS = sum(W/N);
    sigma2AS = var(W);
    IAS = [tauAS - lambdap*sqrt(sigma2AS/N), tauAS, ...
        tauAS + lambdap*sqrt(sigma2AS/N)];
    
end