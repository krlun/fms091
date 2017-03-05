function [t] = drawt(lambda, t, tau, rho)
%DRAWT Summary of this function goes here
%   Detailed explanation goes here
    d = length(t) - 1;
    
    for i = 2:d
        R = rho*(t(i-1)+t(i+1));
        tCand = t(i) + R*2*(rand-1/2);
        if ((t(i-1) < tCand) & (tCand < t(i+1)))
            fCand = f_t(lambda, [t(1:i-1) tCand t(i+1:end)], tau);
            fOld = f_t(lambda, t, tau);
            alpha = min(1, fCand/fOld);
            if (rand < alpha)
                t(i) = tCand;
            end
        end
    end
end

