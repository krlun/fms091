rho = 1.225; % kg/m^3
k = 1.7; lambda = 9.2; % Weibull parameters
lambdap = norminv(0.975); % 95% confidence interval
B = k;
A = lambda;
N = 10000; % # of samples for MC simulation

[I, ITrun] = exc2a(N, k, lambda, lambdap);
[IIS] = exc2b(N, k, lambda, lambdap);
[IAS] = exc2c(N, k, lambda, lambdap);