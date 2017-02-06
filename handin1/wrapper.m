rho = 1.225; % kg/m^3
k = 1.7; lambda = 9.2; % Weibull parameters
lambdap = norminv(0.975); % 95% confidence interval
N = 10000; % # of samples for MC simulation
d = 90; % diameter of rotors

[I, ITrun] = exc2a(N, k, lambda, lambdap);
[IIS] = exc2b(N, k, lambda, lambdap);
[IAS] = exc2c(N, k, lambda, lambdap);
[P] = exc2d(k, lambda);
[INormalized] = exc2e(k, lambda, rho, d, IAS);
[capfact, availfact] = exc2f(N, k, lambda);

[C] = exc3b(N, IAS(2), k, lambda);
[VPXPY, SPXPY] = exc3c(N, IAS(2), C, k, lambda);
[ILess, IEqual, IMore] = exc3d(N, k, lambda, lambdap);