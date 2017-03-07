function [t, accepted] = drawt(lambda, t, tau, rho)
%DRAWT draws new t's according to a Metropolis scheme, as well as
%   calculating the acceptance rate for the various breakpoints.
    d = length(t) - 1;
    accepted = zeros(1,d-1);
    
    for i = 2:d
        R = rho(i-1)*(t(i+1)-t(i-1));
        tCand = t(i) + R*2*(rand-1/2);
        if ((t(i-1) < tCand) && (tCand < t(i+1)))
            fCand = f_t(lambda, [t(1:i-1) tCand t(i+1:end)], tau);
            fOld = f_t(lambda, t, tau);
            alpha = min(1, fCand/fOld);
            if (rand < alpha)
                accepted(i-1) = accepted(i-1) + 1;
                t(i) = tCand;
            end
        end
    end
end