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

cns = []; %Values of c_2(n)
for i = 1:nStop;
    cns = [cns; prob5(N, i)];
end

[A, mu, gamma] = prob6(cns);

%% Problem 9
N = 1000;
nStop = 8;
d = 42;

% Run below to get the cns, which takes quite a few minutes, or use
% the hard coded results below and trust that they have been obtained
% using the loop below.

%vec = (1:nStop)';
%cns = []; %Values of c_2(n)
%for i = vec'
%    cns = [cns; prob9(N, i, d)];
%end

cns = [84;6972;578676;48026057.2680000;3985346315.47853;...
    330735916427.386;27444466767540.6;2.27764373952061e+15];

[A, mu, gamma] = prob6(cns);