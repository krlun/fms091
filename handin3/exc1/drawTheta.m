function [theta] = drawTheta(lambda, psi)
%DRAWTHETA draws a new theta for use in a Gibbs scheme.
    d = length(lambda);
    theta = gamrnd(2*d + 2, 1/(psi + sum(lambda)));
end

