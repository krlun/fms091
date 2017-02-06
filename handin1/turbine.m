%% Problem 2a
load('powercurve_N90.mat')
rho = 1.225; % kg/m^3
k = 1.7; lambda = 9.2; % Weibull parameters
B = k;
A = lambda;
N = 10000; % # of samples for MC simulation

a = zeros(1, N);

MCestimator = P(wblrnd(A, B, 1, N));
tauN = sum(MCestimator)/N;
sigma2 = var(MCestimator);
lambdap = 1.96; % for a 95% confidence interval

I = [tauN - lambdap*sqrt(sigma2)/sqrt(N), tauN + lambdap*sqrt(sigma2)/sqrt(N)]; % untruncated
%%
Fa = wblcdf(3.5, A, B);
Fb = wblcdf(25, A, B);
MCestimatorTrun = P(wblinv(rand(1, N)*(Fb - Fa)+Fa, A, B));
tauNTrun = sum(MCestimatorTrun)/N;
sigma2Trun = var(MCestimatorTrun);

ITrun = [tauNTrun - lambdap*sqrt(sigma2Trun)/sqrt(N), tauNTrun + lambdap*sqrt(sigma2Trun)/sqrt(N)]; %Truncated


% for i = 2:N
%     a(i) = (a(i-1)*(i-1)+P(wblrnd(A,B)))/i;
% end
% plot(a)

%% Problem 2b
MC = gamrnd(12, 1, 1, N);
MCest = P(MC)'.*wblpdf(MC,A,B)./gampdf(MC,12,1);
tauIS = sum(MCest)/N;
sigma2IS = var(MCest);
IIS = [tauIS - lambdap*sqrt(sigma2IS)/sqrt(N), tauIS + lambdap*sqrt(sigma2IS)/sqrt(N)];


%% Problem 2c
X = rand(1, N/2);
Y = 1 - X;
MC1 = P(wblinv(X, A, B));
MC2 = P(wblinv(Y, A, B));
W = (MC1 + MC2)/2;
tauAS = sum(W/(N/2));
sigma2AS = var(W);
IAS = [tauAS - norminv(0.975)*sqrt(sigma2AS)/sqrt(N/2), tauAS + norminv(0.975)*sqrt(sigma2AS)/sqrt(N/2)];

%% Problem 2d)
wblcdf(25, A, B) - wblcdf(3.5, A, B)

%% Problem 2e)
rho = 1.225; d = 90; k = 1.7; lambda = 9.2;
alpha = rho*pi*d^2*k/(8*lambda^k);
a = 3/k + 1; b = lambda^k;
result = alpha/k*gamma(a)*b^a

% numerical test
N = 10000;

MCestimator = sum(1/8*rho*pi*d^2*(wblrnd(A, B, 1, N)).^3)/N

%% Problem 2f)
N = 10000;
MCest = P(wblrnd(A, B, 1, N));
capfact = sum(MCest)/(N*2.5*10^6) %Bra
availfact = wblcdf(25,A,B)-wblcdf(3.5,A,B) %Inte s? bra
%Typ okej sammanlagt
%% Problem 3a) E(X+Y)=E(X)+E(Y)
MC = gamrnd(12, 1, 1, N);
MCest = P(MC)'.*wblpdf(MC,A,B)./gampdf(MC,12,1);
tauIS1 = sum(MCest)/N;
MC = gamrnd(12, 1, 1, N);
MCest = P(MC)'.*wblpdf(MC,A,B)./gampdf(MC,12,1);
tauIS2 = sum(MCest)/N;
tauIS1 + tauIS2
%% 3a) Test
x = 0:30;
plot(P(x)'.*wblpdf(x,A,B))
figure
plot(gampdf(x,12,1.0))
%% Problem 3b)

N = 10000;
alpha = 0.638; p = 3; q = 1.5;

X = 3.5 + (25-3.5).*rand(N,1);
Y = 3.5 + (25-3.5).*rand(N,1);

MCestXY = (P(X).*P(Y).*wblpdf(X, A, B).*wblpdf(Y, A, B).*(1+alpha.*(1-wblcdf(X, A, B).^p).^(q-1).*(1-wblcdf(Y, A, B).^p).^(q-1).*(wblcdf(X, A, B).^p.*(1+p*q)-1).*(wblcdf(Y, A, B).^p.*(1+p*q)-1)))./(1/((25-3.5)*(25-3.5)));
tauXY = sum(MCestXY)/N

MCestX = P(X).*wblpdf(X, A, B)/(1/(25-3.5));
tauX = sum(MCestX)/N;
MCestY = P(Y).*wblpdf(Y, A, B)/(1/(25-3.5));
tauY = sum(MCestY)/N;

cov = tauXY - tauX*tauY;
% MC1 = gamrnd(12, 1, 1, N);
% MCest1 = P(MC)'.*wblpdf(MC,A,B)./gampdf(MC,12,1);
% tauIS1 = sum(MCest1)/N;
% MC2 = gamrnd(12, 1, 1, N);
% MCest2 = P(MC)'.*wblpdf(MC,A,B)./gampdf(MC,12,1);
% tauIS2 = sum(MCest2)/N;
% tauIS12 = sum(MCest1.*MCest2)/N;
% tauIS12 - tauIS1 + tauIS2
%% Problem 3c) V(X+Y)=V(X)+V(Y)+2cov(X,Y) ger variansen. Sqrt ger stdn
% V(P[X] + P[Y]) = V(P[X]) + V(P[Y]) + 2*cov(P[X], P[Y])
% cov(P[X], P[Y]) ber?knades ovan, beh?ver V(P[X]) = V(P[Y])
% V(P[X]) = E[P[X]^2] - E[P[X]]^2

N = 10000;
alpha = 0.638; p = 3; q = 1.5;

X = 3.5 + (25-3.5).*rand(N,1);
Y = 3.5 + (25-3.5).*rand(N,1);

MCestXY = (P(X).*P(Y).*wblpdf(X, A, B).*wblpdf(Y, A, B).*(1+alpha.*(1-wblcdf(X, A, B).^p).^(q-1).*(1-wblcdf(Y, A, B).^p).^(q-1).*(wblcdf(X, A, B).^p.*(1+p*q)-1).*(wblcdf(Y).^p.*(1+p*q)-1)))./(1/((25-3.5)*(25-3.5)));
tauXY = sum(MCestXY)/N;

MCestX = P(X).*wblpdf(X, A, B)/(1/(25-3.5));
tauX = sum(MCestX)/N;
MCestY = P(Y).*wblpdf(Y, A, B)/(1/(25-3.5));
tauY = sum(MCestY)/N;

cov = tauXY - tauX*tauY;


MC1 = gamrnd(12, 1, 1, N);
MCest1 = (P(MC1)'.^2).*wblpdf(MC1, A, B)./gampdf(MC1, 12, 1);
tau1 = sum(MCest1)/N;

MC2 = gamrnd(12, 1, 1, N);
MCest2 = P(MC2)'.*wblpdf(MC2, A, B)./gampdf(MC2, 12, 1);
tau2 = (sum(MCest2)/N);

V = tau1 - tau2^2;
VPXPY = 2*V+2*cov