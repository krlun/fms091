function [cn] = prob3(N, n)
%PROB3 solves the problem of the number of self-avoiding walkings of
% length n in 2 dimenions, using a sequential importance sampling algorithm.
% A uniform distribution over all possible directions is used, using
% N samples.

    gn = 1/4; %Possible directions to choose is 4
    wnis = zeros(1, N); %The weights
    for i = 1:N
        wni = 1;
        matrix = zeros(2*n + 1, 2*n + 1); %In this problem we only consider 
                                          %two dimensions
        matrix(n+1,n+1) = 1; %To keep track of where we have been
        pos = [n+1 n+1]; %Current positions
        selfavoiding = 1; %True
        for j = 1:n
            r = rand;
            if r <= 0.25
                pos(1) = pos(1) - 1; %up
            elseif r <= 0.5
                pos(2) = pos(2) + 1; %right
            elseif r <= 0.75
                pos(1) = pos(1) + 1; %down
            else
                pos(2) = pos(2) - 1; %left
            end     
            if matrix(pos(1),pos(2)) == 1
                selfavoiding = 0; %Not a self-avoiding walk (False)
            else
                matrix(pos(1),pos(2)) = 1; 
            end
            wni = 1/gn*wni*selfavoiding;
        end
        wnis(i) = wni;
    end
    cn = sum(wnis)/N;
end