clear all;
load('coal_mine_disasters.mat');
d = 5;
psi = 1;
rho = 0.02;
samples = 50000;

% Initialize t
tStart = 1658;
tStop = 1980;
t = zeros(1, d+1);
%t(1) = tStart;
%t(end) = tStop;
%for i = 2:d
%    t(i) = tStart + (i-1)*(tStop-tStart)/d;
%end
t = [tStart, sort((tStop - tStart) * rand(1, d-1) + tStart), tStop];

theta = gamrnd(2, 1/psi);
lambda = gamrnd(2, 1/theta, 1, d);

allTheta = zeros(samples, 1);
allLambda = zeros(samples, d);
allt = zeros(samples, d + 1);

NTrials = 0;
NAccepted = 0;

for i = 1:(samples)
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

plot(allt(:, 2:d))
mean(allt)
