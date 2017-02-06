function [P] = exc2d(k, lambda)
%EXC2D calculates the probability (explicitly) that a
%Nordex N90-2500 LS wind turbine produces power given that the wind is
%modelled using a Weibull distribution.

    P = wblcdf(25, lambda, k) - wblcdf(3.5, lambda, k);

end