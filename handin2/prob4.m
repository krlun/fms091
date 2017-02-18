function [cn] = prob4(N, n)
%PROB4 Summary of this function goes here
%   Detailed explanation goes here

%    n = 5; %Number of steps
    wnis = zeros(1, N); %The weights

    for i = 1:N
        wni = 1;
        matrix = zeros(2*n + 1, 2*n + 1); %In this problem we only ...
                                          %consider two dimensions
        matrix(n+1,n+1) = 1; %To keep track of where we have been
        pos = [n+1 n+1]; %Current positions
        selfavoiding = 1; %True
        for j = 1:n
            freespots = []; %1 = up, 2 = right, 3 = down, 4 = left
        if matrix(pos(1)-1,pos(2)) == 0 
            freespots = 1; %up is free
        end
        if matrix(pos(1),pos(2)+1) == 0
            freespots = [freespots 2]; %right is free
        end
        if matrix(pos(1)+1,pos(2)) == 0 
            freespots = [freespots 3]; %down is free
        end
        if matrix(pos(1),pos(2)-1) == 0
            freespots = [freespots 4]; %left is free
        end
        if isempty(freespots) %Not a selfavoiding walk (until we get stuck)
            selfavoiding = 0;
        else
            r = freespots(ceil(rand * length(freespots)));
            if r == 1
                pos(1) = pos(1) - 1; %up
            elseif r == 2
                pos(2) = pos(2) + 1; %right
            elseif r == 3
                pos(1) = pos(1) + 1; %down
            else
                pos(2) = pos(2) - 1; %left
            end
            matrix(pos(1),pos(2)) = 1;
            wni = length(freespots)*wni;
        end
        wni = wni*selfavoiding;   
    end     
    wnis(i) = wni;
    end
    cn = sum(wnis)/N;
end