function [cn] = prob9(N, n, d)
%PROB9 Summary of this function goes here
%   Detailed explanation goes here

    %d = 4;
    %n = 7;
    %N = 200;
    currentWeights = ones(1, N); %De nuvarande vikterna!
    coords = zeros(N, n+1, d); %coords(sampel i, efter n steg, dimension d)
    cn = 1;
    for s = 1:n
        newCoords = zeros(N, s, d);
        probs = cumsum(currentWeights/sum(currentWeights));
        for i = 1:N
            r = rand;
            index = 1;
            for k = 1:N
                if (r > probs(k))
                    index = k;
                else
                    break;
                end
            end
            newCoords(i, :, :) = coords(k, 1:s, :);
        end
        coords(:, 1:s, :) = newCoords; %Kordinaterna blir de nya
        currentWeights = ones(1, N); %Nollst?ller vikterna
        newCoords = zeros(N, d); %De nya kordinaterna nollst?lls
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
            end
            currentWeights(i) = length(freespots(1,:));
        end
        coords(:,s+1,:) = newCoords;
        cn = cn*sum(currentWeights)/N;
    end

end
