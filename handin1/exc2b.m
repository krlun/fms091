function [IIS] = exc2b(N, k, lambda, lambdap)
%EXC2B uses importance sampling with a gamma function as g(x) to
%reduce the variance in estimating the confidence interval for the power
%output of a Nordex N90-2500 LS wind turbine. The wind is modelled using
%a Weibull distribution.

    load('powercurve_N90.mat');
    
    MC = gamrnd(12, 1, 1, N);
    MCest = P(MC)'.*wblpdf(MC, lambda, k)./gampdf(MC, 12, 1);
    tauIS = sum(MCest)/N;
    sigma2IS = var(MCest);
    IIS = [tauIS - lambdap*sqrt(sigma2IS/N), tauIS, ...
        tauIS + lambdap*sqrt(sigma2IS/N)];

end