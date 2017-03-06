% Task b)
clear all;
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

betaLB = beta - betaSort(ceil((1-alpha/2)*samples));
betaUB = beta - betaSort(ceil(alpha/2*samples));
betaI = [betaLB betaUB]

muLB = mu - muSort(ceil((1-alpha/2)*samples));
muUB = mu - muSort(ceil(alpha/2*samples));
muI = [muLB muUB]

% Task c), use the betas and mus from b)
T = 3*14*100;
returnValues = zeros(1, samples);
for i = 1:samples
    returnValues(i) = F_inv(1-1/T, betas(i), mus(i));
end

meanReturnValue = mean(returnValues);
returnValueSort = sort(returnValues - meanReturnValue);
returnValueLB = meanReturnValue - returnValueSort(ceil((1-alpha)*samples));
returnValueUB = meanReturnValue - returnValueSort(ceil((alpha)*samples));
returnValueI = [returnValueLB returnValueUB]

