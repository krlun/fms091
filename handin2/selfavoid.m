% Initializing
N = 10000; %Number of simulations
d = 2; %Number of dimensions
%% Problem 3
d = 2;
n = 3; %Number of steps
gn = 1/4; %Possible directions to choose is 4
wnis = zeros(1, N); %The weights
phiXi = zeros(1, N); %A boolean function
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
    phiXi(i) = selfavoiding;
    wnis(i) = wni;
end
Ephi = sum(phiXi.*wnis)/sum(wnis); %Sannolikheten att en walk är selfavoiding
cn = Ephi*4^n
cnn = sum(wnis)/N
lk,jmhng
%% Problem 4
d = 2;
n = 3; %Number of steps
wnis = zeros(1, N); %The weights
phiXi = zeros(1, N); %A boolean function
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
           length(freespots);
           matrix(pos(1),pos(2)) = 1;
           wni = length(freespots)*wni;
       end
       if j == n
           phiXi(i) = selfavoiding;
           wnis(i) = wni;
       end
      
    end     
end
Ephi = sum(phiXi.*wnis)/(N*(2*d)^n) %Sannolikheten att en walk är selfavoiding
cn = Ephi*(2*d)^n %Above: Should be divided by N*(2*d)^n

%% Problem 5


%% Problem 6


%% Problem 7


%% Problem 8


%% Problem 9

