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

bootstrapParameters = zeros(samples, 2);
for i = 1:samples
    [beta, mu] = est_gumbel(simulatedWaves(i, :));
    bootstrapParameters(i, 1) = beta;
    bootstrapParameters(i, 2) = mu;
end
