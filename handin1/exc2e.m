function [ output_args ] = exc2e(k, lambda, rho, d, I)
%EXC2E Summary of this function goes here
%   Detailed explanation goes here

    alpha = rho*pi*d^2*k/(8*lambda^k);
    a = 3/k + 1; b = lambda^k;
    result = alpha/k*gamma(a)*b^a
    

    % numerical test
    N = 10000;

    MCestimator = sum(1/8*rho*pi*d^2*(wblrnd(lambda, k, 1, N)).^3)/N

end

