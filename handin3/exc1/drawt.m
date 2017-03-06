function [t, accepted] = drawt(lambda, t, tau, rho)
%DRAWT Summary of this function goes here
%   Detailed explanation goes here
    d = length(t) - 1;
    accepted = zeros(1,d-1);
%    tCand = zeros(1, length(t));
    
    for i = 2:d
%        R = rho*(t(i+1)-t(i-1));
%        tCand(i) = t(i) + R*2*(rand-1/2);
%    end
%    tCand(1) = t(1);
%    tCand(end) = t(end);
        R = rho(i-1)*(t(i+1)-t(i-1));
        tCand = t(i) + R*2*(rand-1/2);
        if ((t(i-1) < tCand) && (tCand < t(i+1)))
            fCand = f_t(lambda, [t(1:i-1) tCand t(i+1:end)], tau);
%            fCand = f_t(lambda, tCand, tau);
            fOld = f_t(lambda, t, tau);
            alpha = min(1, fCand/fOld);
            if (rand < alpha)
                accepted(i-1) = accepted(i-1) + 1;
                t(i) = tCand;
%                t = tCand;
            end
%             if fOld < fCand
%                 t(i) = tCand;
%             elseif (rand < fCand/fOld)
%                 t(i) = tCand;
%             end
        end
    end
end