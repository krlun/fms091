nrOfSamples = 100;
N = 5000;
n = 7;
lambdap = norminv(0.975);

samples = zeros(1, nrOfSamples);


parfor i = 1:nrOfSamples
    i
    samples(i) = prob5(N, n);
end

mu = sum(samples)/nrOfSamples;
v = var(samples);
I = [mu - lambdap*sqrt(v/nrOfSamples), mu, mu + lambdap*sqrt(v/nrOfSamples)];
