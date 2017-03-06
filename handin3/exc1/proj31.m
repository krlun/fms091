load('coal_mine_disasters.mat');
psi = 1;
d = 3; %Breakpoints + 1
rho = ones(1,d-1);
burn_in = 5000;
samples = 20000;

% Initialize t
tStart = 1658;
tStop = 1980;
t = [tStart, 1800, 1900, tStop];
%t = zeros(1, d+1);
%t(1) = tStart;
%t(end) = tStop;
%for i = 2:d
%    t(i) = tStart + (i-1)*(tStop-tStart)/d;
%end
%t = [tStart, sort((tStop - tStart) * rand(1, d-1) + tStart), tStop];


theta = gamrnd(2, 1/psi);
lambda = gamrnd(2, 1/theta, 1, d);

allTheta = zeros(samples, 1);
allLambda = zeros(samples, d);
allt = zeros(samples, d + 1);


for i = 1:burn_in
    theta = drawTheta(lambda, psi);
    lambda = drawLambda(theta, t, T);
    [t, accepted] = drawt(lambda, t, T, rho);
end
NTrials = 0;
NAccepted = zeros(1,d-1);

for i = 1:samples
    theta = drawTheta(lambda, psi);
    lambda = drawLambda(theta, t, T);
    [t, accepted] = drawt(lambda, t, T, rho);
    NTrials = NTrials + (d-1);
    NAccepted = NAccepted + accepted;
    allTheta(i, :) = theta;
    allLambda(i, :) = lambda;
    allt(i, :) = t;
end

acceptanceRatio = NAccepted/NTrials

plot(allt(:,2:d))
medel = mean(allt(:,2:d))