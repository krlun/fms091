function [A, mu, gamma] = prob6(N, nStop)
%PROB6 Summary of this function goes here
%   Detailed explanation goes here

    %ln(c_n(2)) + ln(n) = ln(A_2) + n*ln(mu_d) + gamma*logn
    vec = (1:nStop)';
    cns = []; %Values of c_2(n)
    N = 10000;
    for i = vec'
        cns = [cns; prob5(N, i)];
    end
    y = log(cns) + log(vec); %ln(cn(2))+ln(n)
    X = zeros(nStop, 3);
    X(:, 1) = ones(nStop, 1);
    X(:, 2) = vec;
    X(:, 3) = log(vec);
    B = (X'*X)\X'*y; %B(1) = log(A), B(2) = log(mu), B(3) = gamma.
    A = exp(B(1));
    mu = exp(B(2));
    gamma = B(3);

end

