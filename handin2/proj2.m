N = 10000; n = 7; d = 2; nStop = 10;

%[cn] = prob3(N, n);

%[cn] = prob4(N, n);

%[cn] = prob5(N, n);



A = zeros(1, 10);
mu = zeros(1, 10);
gamma = zeros(1, 10);
parfor i = 1:10
    i
    [A(i), mu(i), gamma(i)] = prob6(N, nStop);
end

%[A, mu, gamma] = prob6(N, nStop);


%[cn] = prob9(N, n, d);