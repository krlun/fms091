clear all;
load('coal_mine_disasters.mat');
d = 2;
psi = 1;
rho = 2;
burn_in = 1000;
samples = 100000;

% Initialize t
tStart = 1658;
tStop = 1980;
t = zeros(1, d+1);
t(1) = tStart;
t(end) = tStop;
%for i = 2:d
%    t(i) = tStart + (i-1)*(tStop-tStart)/d;
%end

t = [tStart, sort((tStop - tStart) * rand(1, d-1) + tStart), tStop];


theta = gamrnd(2, 1/psi);
lambda = gamrnd(2, 1/theta, 1, d);

all_theta = zeros(samples, 1);
all_lambda = zeros(samples, d);
all_t = zeros(samples, d + 1);

for i = 1:(samples+burn_in)
    theta = drawTheta(lambda, psi);
    lambda = drawLambda(theta, t, T);
    t = drawt(lambda, t, T, rho);
    all_theta(i,:) = theta;
    all_lambda(i,:) = lambda;
    all_t(i,:) = t;
end

plot(all_t(:,2:d))
mean(all_t)
