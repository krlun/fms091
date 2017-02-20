%% Problem 3
N = 1000;
nrOfSamples = 100;
lambdap = norminv(0.975);
nStart = 1; nStop = 8;


samples = zeros(nStop-nStart + 1, nrOfSamples);
I = zeros(nStop-nStart + 1, 3);

for n = nStart:nStop
    parfor j = 1:nrOfSamples
        samples(n, j) = prob3(N, n);
    end
    mu = sum(samples(n, :))/nrOfSamples;
    v = var(samples(n, :));
    I(n, :) = [mu - lambdap*sqrt(v/nrOfSamples), mu, mu + lambdap*sqrt(v/nrOfSamples)];
end

%% Problem 4
N = 1000;
nrOfSamples = 100;
lambdap = norminv(0.975);
nStart = 1; nStop = 8;

samples = zeros(nStop-nStart + 1, nrOfSamples);
I = zeros(nStop-nStart + 1, 3);

for n = nStart:nStop
    parfor j = 1:nrOfSamples
        samples(n, j) = prob4(N, n);
    end
    mu = sum(samples(n, :))/nrOfSamples;
    v = var(samples(n, :));
    I(n, :) = [mu - lambdap*sqrt(v/nrOfSamples), mu, mu + lambdap*sqrt(v/nrOfSamples)];
end

%% Problem 5
N = 1000;
nrOfSamples = 100;
lambdap = norminv(0.975);
nStart = 1; nStop = 8;

samples = zeros(nStop-nStart + 1, nrOfSamples);
I = zeros(nStop-nStart + 1, 3);

for n = nStart:nStop
    parfor j = 1:nrOfSamples
        samples(n, j) = prob5(N, n);
    end
    mu = sum(samples(n, :))/nrOfSamples;
    v = var(samples(n, :));
    I(n, :) = [mu - lambdap*sqrt(v/nrOfSamples), mu, mu + lambdap*sqrt(v/nrOfSamples)];
end

%% Problem 6
N = 1000;
nStop = 8;
[A, mu, gamma] = prob6(N, nStop);

%% Problem 9
N = 1000;
d = 9;
nrOfSamples = 100;
lambdap = norminv(0.975);
nStart = 1; nStop = 8;

samples = zeros(nStop-nStart + 1, nrOfSamples);
I = zeros(nStop-nStart + 1, 3);

for n = nStart:nStop
    parfor j = 1:nrOfSamples
        samples(n, j) = prob9(N, n, d);
    end
    mu = sum(samples(n, :))/nrOfSamples;
    v = var(samples(n, :));
    I(n, :) = [mu - lambdap*sqrt(v/nrOfSamples), mu, mu + lambdap*sqrt(v/nrOfSamples)];
end

