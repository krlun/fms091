% Exercise 1
load('coal_mine_disasters.mat');
psi = 2.33;
d = 4; %Breakpoints + 1
rho = ones(1,d-1);
rho(1) = 0.08;
rho(2) = 0.005;
rho(3) = 0.03;
burn_in = 4000;
samples = 20000;

% Initialize t
tStart = 1658;
tStop = 1980;
t = [tStart, 1700, 1800, 1930, tStop];
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
    NTrials = NTrials + 1;
    NAccepted = NAccepted + accepted;
    allTheta(i, :) = theta;
    allLambda(i, :) = lambda;
    allt(i, :) = t;
end

acceptanceRatio = NAccepted/NTrials

plot(allt(:,2:d))
medel = mean(allt(:,2:d))
%%
% Exercise 2
% Task 2b)
load('atlantic.txt');
[beta, mu] = est_gumbel(atlantic);

samples = 10000;

simulatedWaves = zeros(samples, length(atlantic));

for i = 1:samples
    for j = 1:length(atlantic)
        simulatedWaves(i, j) = F_inv(rand, beta, mu);
    end
end

betas = zeros(samples, 1);
mus = zeros(samples, 1);
for i = 1:samples
    [betaEst, muEst] = est_gumbel(simulatedWaves(i, :));
    betas(i) = betaEst;
    mus(i) = muEst;
end
betaSort = sort(betas - beta);
muSort = sort(mus - mu);
alpha = 0.05;

betaLB = 2*beta - mean(beta) - betaSort(ceil((1-alpha/2)*samples)); %Biased-corrected estimate
betaUB = 2*beta - mean(beta) - betaSort(ceil(alpha/2*samples)); %Biased-corrected estimate
betaI = [betaLB betaUB]

muLB = 2*mu - mean(mu) - muSort(ceil((1-alpha/2)*samples)); %Biased-corrected estimate
muUB = 2*mu - mean(mu) - muSort(ceil(alpha/2*samples)); %Biased-corrected estimate
muI = [muLB muUB]

% Plots for task 2b
histogram(betas,100)
title('Distribution of 10000 parametric bootstrapped estimates of \beta')
xlabel('Value of \beta')
ylabel('Number of occasions for the value')
figure
histogram(mus,100)
title('Distribution of 10000 parametric bootstrapped estimates of \mu')
xlabel('Value of \mu')
ylabel('Number of occasions for the value')

% Task c), use the betas and mus from b)
T = 3*14*100;
returnValues = zeros(1, samples);
for i = 1:samples
    returnValues(i) = F_inv(1-1/T, betas(i), mus(i));
end

meanRV = F_inv(1-1/T, beta, mu);
meanReturnValue = mean(returnValues);
returnValueSort = sort(returnValues - meanReturnValue);
returnValueLB = 2*meanRV - meanReturnValue - returnValueSort(ceil((1-alpha)*samples)); %Biased-corrected estimate
returnValueUB = 2*meanRV - meanReturnValue - returnValueSort(ceil((alpha)*samples)); %Biased-corrected estimate
returnValueI = [returnValueLB returnValueUB]
% Plots for task 2c
histogram(returnValues,100)
title('Distribution of 10000 parametric bootstrapped estimates of the 100-year return value')
xlabel('Estimated return value')
ylabel('Number of occasions for the value')