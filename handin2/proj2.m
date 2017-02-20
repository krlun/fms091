%% Problem 3
N = 1000;
nrOfSamples = 100;
lambdap = norminv(0.975);
nStart = 1; nStop = 8;


samples = zeros(nStop-nStart + 1, nrOfSamples);
I = zeros(nStop-nStart + 1, 3);

for n = nStart:nStop
    for j = 1:nrOfSamples
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
    for j = 1:nrOfSamples
        samples(n, j) = prob4(N, n);
    end
    mu = sum(samples(n, :))/nrOfSamples;
    v = var(samples(n, :));
    I(n, :) = [mu - lambdap*sqrt(v/nrOfSamples), mu, mu + lambdap*sqrt(v/nrOfSamples)];
end

%%

samples = zeros(1, nrOfSamples);
parfor i = 1:nrOfSamples
    i
    samples(i) = prob9(N, n);
end

mu = sum(samples)/nrOfSamples;
v = var(samples);
I = [mu - lambdap*sqrt(v/nrOfSamples), mu, mu + lambdap*sqrt(v/nrOfSamples)];


%[cn] = prob3(N, n);

%[cn] = prob4(N, n);

%[cn] = prob5(N, n);



%A = zeros(1, 10);
%mu = zeros(1, 10);
%gamma = zeros(1, 10);
%parfor i = 1:10
%    i
%    [A(i), mu(i), gamma(i)] = prob6(N, nStop);
%end

%[A, mu, gamma] = prob6(N, nStop);


%[cn] = prob9(N, n, d);