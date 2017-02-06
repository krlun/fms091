function [I, ITrun] = exc2a(N, lambda, k, lambdap)
%EXC2B calculates a 95% confidence interval for the expected power output
%of a Nordex N90-2500 LS wind turbine, given a that a Weibull distribution 
%describes the wind, both using a non truncated interval for the wind, as
%well as a truncated interval where the wind falls within the span where
%the turbine actually produces power.

    load('powercurve_N90.mat');

    MCEst = P(wblrnd(lambda, k, 1, N));
    tauN = sum(MCEst)/N;
    sigma2 = var(MCEst);

    I = [tauN - lambdap*sqrt(sigma2/N), tauN, ...
        tauN + lambdap*sqrt(sigma2/N)]; %Untruncated
    
    Fa = wblcdf(3.5, lambda, k);
    Fb = wblcdf(25, lambda, k);
    MCEstTrun = P(wblinv(rand(1, N)*(Fb - Fa)+Fa, lambda, k));
    tauNTrun = sum(MCEstTrun)/N;
    sigma2Trun = var(MCEstTrun);

    ITrun = [tauNTrun - lambdap*sqrt(sigma2Trun/N), tauNTrun, ...
        tauNTrun + lambdap*sqrt(sigma2Trun/N)]; %Truncated

end