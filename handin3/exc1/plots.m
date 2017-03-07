% N = 30000;
% k = 2;
% %mu = 0.8584;
% mu = 2.33;
% %2.33 = 2/x <=> x = 2/2.33
% sum(gamrnd(k, 1/mu, 1, N))/N

% subplot(2, 1, 1);
% plot(allTheta(:));
% xlabel('#sample');
% ylabel('\theta');
% title('Trace plot for \theta');
% hold on;
% subplot(2, 1, 2);
% autocorr(allTheta, 300);
% xlabel('lag');
% ylabel('autocorrelation');
% title('Autocorrelation plot for \theta');
% mean(allTheta)

% subplot(2, 2, 1);
% hold on;
% autocorr(allLambda(:, 1), 300);
% xlabel('lag');
% ylabel('autocorrelation');
% title('Autocorrelation plot for \lambda_1');
% subplot(2, 2, 2);
% autocorr(allLambda(:, 2), 300);
% xlabel('lag');
% ylabel('autocorrelation');
% title('Autocorrelation plot for \lambda_2');
% subplot(2, 2, 3);
% autocorr(allLambda(:, 3), 300);
% xlabel('lag');
% ylabel('autocorrelation');
% title('Autocorrelation plot for \lambda_3');
% subplot(2, 2, 4);
% autocorr(allLambda(:, 4), 300);
% xlabel('lag');
% ylabel('autocorrelation');
% title('Autocorrelation plot for \lambda_4');

subplot(2, 2, 1);
hold on;
autocorr(allt(:, 2), 300);
xlabel('lag');
ylabel('autocorrelation');
title('Autocorrelation plot for t_2');
subplot(2, 2, 2);
autocorr(allt(:, 3), 300);
xlabel('lag');
ylabel('autocorrelation');
title('Autocorrelation plot for t_3');
subplot(2, 2, 3);
autocorr(allt(:, 4), 300);
xlabel('lag');
ylabel('autocorrelation');
title('Autocorrelation plot for t_4');
