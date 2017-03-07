function [n] = calcn(t, tau)
%CALCN calculates the number of accidents in a given time interval.
    d = length(t) - 1;
    n = zeros(1, d);
    for i = 1:d
        n(i) = sum((t(i) <= tau) & (tau < t(i+1)));
    end
end

