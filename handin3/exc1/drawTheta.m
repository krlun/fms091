function [theta] = drawTheta(lambda, psi)
%DRAWTHETA Summary of this function goes here
%   Detailed explanation goes here
    d = length(lambda);
    theta = gamrnd(2*d + 2, 1/(psi + sum(lambda)));
end

