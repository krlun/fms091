function [confLess, confEqual, confMore] = exc3d(N, k, lambda, lambdap)
%EXC3D calculates the probabilities P(P(V1) + P(V2) < 2.5*10^6), 
%P(P(V1) + P(V2) > 2.5*10^6) and P(P(V1) + P(V2) = 2.5*10^6) and
%returns three confidence intervals for these quantities.

    load('powercurve_N90.mat');

    alpha = 0.638; p = 3; q = 1.5;

    f = @(v) wblpdf(v, lambda, k);
    F = @(v) wblcdf(v, lambda, k);
    fv1v2 = @(v1, v2) f(v1).*f(v2).*(1+alpha*(1-F(v1).^p).^(q- ...
        1).*(1-F(v2).^p).^(q-1).*(F(v1).^p.*(1+p*q)- ...
        1).*(F(v2).^p.*(1+p*q)-1));
    
    R = 30*rand(N, 2);

    power(:,1) = P(R(:,1));
    power(:,2) = P(R(:,2));
    powerTotal = power(:,1) + power(:,2);
    IMore = powerTotal > 2.5*10^6;
    ILess = powerTotal < 2.5*10^6;
    IEqual = powerTotal == 2.5*10^6;
    
    W = fv1v2(R(:,1), R(:,2)) * 30^2; % f(v1,v2)/g(v1,v2)
    
    tauLess = sum(W.*ILess)/N;
    VLess = var(W.*ILess);
    confLess = [tauLess - lambdap*sqrt(VLess/N), tauLess, ...
        tauLess + lambdap * sqrt(VLess/N)];

    tauEqual = sum(W.*IEqual)/N;
    VEqual = var(W.*IEqual);
    confEqual = [tauEqual - lambdap*sqrt(VEqual/N), tauEqual, ...
        tauEqual + lambdap*sqrt(VEqual/N)];

    tauMore = sum(W.*IMore)/N;
    VMore = var(W .* IMore);
    confMore = [tauMore - lambdap*sqrt(VMore/N), tauMore, ...
        tauMore + lambdap * sqrt(VMore/N)];

end