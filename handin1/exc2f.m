function [capfact, availfact] = exc2f(N, k, lambda)
%EXC2F Summary of this function goes here
%   Detailed explanation goes here

    load('powercurve_N90.mat');

    MCest = P(wblrnd(lambda, k, 1, N));
    capfact = sum(MCest)/(N*2.5*10^6); %Bra
    availfact = wblcdf(25, lambda, k) - wblcdf(3.5, lambda, k); %Inte s? bra

end