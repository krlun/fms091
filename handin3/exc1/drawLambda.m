function [lambda] = drawLambda(theta, t, tau)
%DRAWLAMBDA draws new lambdas for use in a Gibbs scheme.
    tDiff = t(2:end) - t(1:end-1);
    n = calcn(t, tau);
    lambda = gamrnd(n + 2, 1./(theta + tDiff));
end

