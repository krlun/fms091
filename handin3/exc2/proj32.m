% Task b)
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
%% Plots of task 2b
histogram(betas,100)
title('Distribution of 10000 parametric bootstrapped estimates of \beta')
xlabel('Value of \beta')
ylabel('Number of occasions for the value')
figure
histogram(mus,100)
title('Distribution of 10000 parametric bootstrapped estimates of \mu')
xlabel('Value of \mu')
ylabel('Number of occasions for the value')
%%
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
%% Plots of task 2c
histogram(returnValues,100)
title('Distribution of 10000 parametric bootstrapped estimates of the 100-year return value')
xlabel('Estimated return value')
ylabel('Number of occasions for the value')