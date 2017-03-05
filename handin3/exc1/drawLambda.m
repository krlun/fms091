function [lambda] = drawLambda(theta, t, tau)
%DRAWLAMBDA Summary of this function goes here
%   Detailed explanation goes here
    tDiff = t(2:end) - t(1:end-1);
    n = calcn(t, tau);
    lambda = gamrnd(n + 2, 1./(theta + tDiff));
end

