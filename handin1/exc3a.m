function [tau] = exc3a(N, k, lambda)
%EXC3A calculates the expected power output from two Nordex N90-2500 LS
%wind turbines, using importance sampling with draws from a gamma
%distribution.

    load('powercurve_N90.mat');
    MC = gamrnd(12, 1, 1, N);
    MCest = P(MC)'.*wblpdf(MC,lambda,k)./gampdf(MC,12,1);
    tauIS1 = sum(MCest)/N;
    MC = gamrnd(12, 1, 1, N);
    MCest = P(MC)'.*wblpdf(MC,lambda,k)./gampdf(MC,12,1);
    tauIS2 = sum(MCest)/N;
    tau = tauIS1 + tauIS2;
    
end

