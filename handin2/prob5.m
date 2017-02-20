function [cn] = prob5(N, n)
%PROB5 Summary of this function goes here
%   Detailed explanation goes here

    %n = 6;
    weights = zeros(n, N); %The weights
    matrices = zeros(N, 2*n + 1, 2*n + 1); %Keeping track of the N walks
    pos = zeros(N,2);
    for i = 1:N
        matrices(i,n+1,n+1) = 1;
        pos(i,1) = n+1;
        pos(i,2) = n+1;
    end
    currentWeights = ones(1, N);
    for j = 1:n
        j
        newMatrices = zeros(N,2*n+1,2*n+1);
        probabilities = cumsum(currentWeights/sum(currentWeights)); 
        newPos = zeros(N,2);
        for i = 1:N
            r = rand;
            index = 1;
            for k = 1:N
                if (r > probabilities(k))
                    index = k;
                else
                    break;
                end
            end
            newMatrices(i, :, :) = matrices(index, :, :);
            newPos(i, :) = pos(index, :);
        end
        matrices = newMatrices;
        pos = newPos;
        currentWeights = ones(1, N);
        for i = 1:N
            freespots = []; %1 = up, 2 = right, 3 = down, 4 = left
            if matrices(i,pos(i,1)-1,pos(i,2)) == 0 
                freespots = 1; %up is free
            end
            if matrices(i,pos(i,1),pos(i,2)+1) == 0
                freespots = [freespots 2]; %right is free
            end
            if matrices(i,pos(i,1)+1,pos(i,2)) == 0 
                freespots = [freespots 3]; %down is free
            end
            if matrices(i,pos(i,1),pos(i,2)-1) == 0
                freespots = [freespots 4]; %left is free
            end
            if ~isempty(freespots)
                r = freespots(randi(length(freespots)));
                if r == 1
                    pos(i,1) = pos(i,1) - 1; %up
                elseif r == 2
                    pos(i,2) = pos(i,2) + 1; %right
                elseif r == 3
                    pos(i,1) = pos(i,1) + 1; %down
                else
                    pos(i,2) = pos(i,2) - 1; %left
                end
                matrices(i,pos(i,1),pos(i,2)) = 1;
            end
            currentWeights(i) = length(freespots);
        end
        weights(j,:) = currentWeights;
    end
    
    cn = 1;
    for j = 1:n
        cn = cn*sum(weights(j,:))/N;
    end
end