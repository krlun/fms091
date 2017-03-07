function [ft] = f_t(lambda, t, tau)
%F_T calculates the value of the distribution function for f(t| theta,
%   lambda, tau).
    if issorted(t)
        tDiff = t(2:end) - t(1:end-1);
        n = calcn(t, tau);
        ft = exp(sum(log(lambda).*n + log(tDiff) - lambda.*tDiff));
    else
        ft = 0;
    end
end

