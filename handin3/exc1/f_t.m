function [ft] = f_t(lambda, t, tau)
%F_T Summary of this function goes here
%   Detailed explanation goes here
    if issorted(t)
        tDiff = t(2:end) - t(1:end-1);
        n = calcn(t, tau);
        ft = exp(sum(log(lambda).*n + log(tDiff) - lambda.*tDiff));
    else
        ft = 0;
    end
end

