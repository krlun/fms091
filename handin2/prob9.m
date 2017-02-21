function [cn] = prob9(N, n, d)
%PROB9 solves the problem of the number of self-avoiding walkings of
% length n in d dimenions, using a sequential importance sampling with
% resampling algorithm. A uniform distribution over all possible free
% directions is used, using N samples.

    currentWeights = ones(1, N);
    coords = zeros(N, n+1, d); %coords(sample i, after n steg, dimension d)
    cn = 1;
    for s = 1:n
        newCoords = zeros(N, s, d);
        probs = cumsum(currentWeights/sum(currentWeights));
        for i = 1:N
            r = rand;
            for k = 1:N
                if (r < probs(k))
                    break;
                end
            end
            newCoords(i, :, :) = coords(k, 1:s, :);
        end
        coords(:, 1:s, :) = newCoords; %Copy new coords
        currentWeights = ones(1, N); %Resetting the weights
        newCoords = zeros(N, d); %The new coordinates zeroed
        for i = 1:N
            currentPos = squeeze(coords(i, s, :));
            possibleNext = [];
            for j = 1:(2*d)
                possibleNext = [possibleNext currentPos];
            end
            for dim = 1:d
                possibleNext(dim, 2*dim-1) = possibleNext(dim, 2*dim-1) + 1;
                possibleNext(dim, 2*dim) = possibleNext(dim, 2*dim) - 1;
            end     
            freespots = [];
            currCords = (squeeze(coords(i,:,:)));
            for j = 1:(2*d)
                check = ismember(currCords, possibleNext(:, j)', 'rows');
                if ~any(check)
                    freespots = [freespots possibleNext(:, j)];
                end
            end
            if ~isempty(freespots)
                r = ceil(rand * length(freespots(1, :)));
                newCoords(i, :) = freespots(:, r);
                currentWeights(i) = length(freespots(1,:));
            else
                currentWeights(i) = 0;
            end
        end
        coords(:,s+1,:) = newCoords;
        cn = cn*sum(currentWeights)/N;
    end

end
