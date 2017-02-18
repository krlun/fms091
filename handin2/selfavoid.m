% Problem 3
N = 10000;
n = 3; %Number of steps
gn = 1/4; %Possible directions to choose is 4
wnis = zeros(1, N); %The weights
%phiXi = zeros(1, N); %A boolean function
for i = 1:N
    wni = 1;
    matrix = zeros(2*n + 1, 2*n + 1); %In this problem we only consider two dimensions
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
       wni = 1/gn*wni*selfavoiding; %I detta fallet alltid samma.
      
    end   
    %phiXi(i) = selfavoiding;
    wnis(i) = wni;
end
%Ephi = sum(phiXi.*wnis)/sum(wnis); %Sannolikheten att en walk ?r selfavoiding
%cn = Ephi*4^n
cn = sum(wnis)/N

%% Problem 4
N = 10000;
n = 5; %Number of steps
wnis = zeros(1, N); %The weights
%phiXi = zeros(1, N); %A boolean function
for i = 1:N
    wni = 1;
    matrix = zeros(2*n + 1, 2*n + 1); %In this problem we only consider two dimensions
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
cn = sum(wnis)/N
%% Problem 5
N = 10000;
n = 5;
weights = zeros(n, N); %The weights
matrices = zeros(N, 2*n + 1, 2*n + 1); %Directions of the N walks
pos = zeros(N,2);
for i = 1:N
   matrices(i,n+1,n+1) = 1;
   pos(i,1) = n+1;
   pos(i,2) = n+1;
end
currentWeights = ones(1, N);
for j = 1:n
    newMatrices = zeros(i,2*n+1,2*n+1);
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
        newPos(i,:) = pos(index,:);
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
cn

%% Problem 6
%ln(c_n(2))+ln(n)=ln(A_2)+n*ln(mu_d)+gamma*logn
vec = (1:n)';
cns = []; %Värden på c_2(n)
N = 10000;
for n = 1:10
    cns = [cns; prob5(N,n)];
end
y = log(cns) + log(vec); %ln(cn(2))+ln(n)
X = zeros(n, 3);
X(:, 1) = ones(n, 1);
X(:, 2) = vec;
X(:, 3) = log(vec);
B = (X'*X)\X'*y; %B(1) = log(A), B(2) = log(mu), B(3) = gamma.
A = exp(B(1))
mu = exp(B(2))
gamma = B(3)
%% Problem 9
d = 2;
n = 5;
N = 2000;
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
        %possibleNext = repmat(currentPos, 1, 2*d);
        for dim = 1:d
           possibleNext(dim, 2*dim-1) = possibleNext(dim, 2*dim-1) + 1;
           possibleNext(dim, 2*dim) = possibleNext(dim, 2*dim) - 1;
        end     
        freespots = [];
        for j = 1:(2*d)
            currCords = (squeeze(coords(i,:,:)));
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
cn

%% Rester av problem 9

% d = 2;
% n = 3;
% N = 10;
% currentWeights = ones(1, N);
% coords = zeros(1, N, d);
% cn = 1;
% for s = 1:n
%     if (s ~= 1)
%         newCoords = zeros(s-1, N, d);
%         probs = cumsum(currentWeights/sum(currentWeights));
%         for i = 1:N
%             r = rand;
%             index = 1;
%             for k = 1:N
%                 if (r > probs(k))
%                     index = k;
%                 else
%                     break;
%                 end
%             end
%             newCoords(:, i, :) = coords(:, k, :);
%         end
%     end
%     coords = newCoords;
%     currentWeights = ones(1,N);
%     newCoords = zeros(1, N, d);
%     for i = 1:N
%         p = 1;
%         if s == 1
%            p = 0; 
%         end
%         currentPos = squeeze(coords(s-p, i, :));
%         possibleNext = [];
%         for j = 1:(2*d)
%             possibleNext = [possibleNext currentPos];
%         end
%         %possibleNext = repmat(currentPos, 1, 2*d);
%         for dim = 1:d
%            possibleNext(dim, 2*dim-1) = possibleNext(dim, 2*dim-1) + 1;
%            possibleNext(dim, 2*dim) = possibleNext(dim, 2*dim) - 1;
%         end     
%         freespots = [];
%         for j = 1:(2*d)
%             currCords = (squeeze(coords(:,i,:)))';
%             check = ismember(currCords, possibleNext(:, j)', 'rows');
%             if ~any(check)
%                 freespots = [freespots possibleNext(:, j)];
%             end
%         end
%         if ~isempty(freespots)
%             r = ceil(rand * length(freespots));
%             newCoords(1, i, :) = freespots(:, r);
%         end
%         currentWeights(i) = length(freespots(1,:));
%     end
%     coords = [coords newCoords];
%     x = 3
%     cn = cn*sum(currentWeights(i))/N
% end
% cn