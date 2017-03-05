psi = 1;
rho = 1/3;
d = 2; %d-1 breakpoints.

tau = load('coal_mine_disasters');
tau = tau.T;
theta = gamrnd(2, psi);
lambda = gamrnd(2, theta, 1, d);

t1 = 1658;
tlast = 1980;
t = linspace(t1, tlast, d + 1);



iterations = 10;
for i = 1:iterations
     
    %Draw theta with Gibbs sampling
    while 1
        theta = gamrnd(2, psi);
        p = F_theta(theta, psi, lambda);
        u = rand*gamcdf(theta, 2, psi);
        if u <= p
           break; 
        end
    end
    
    %Draw lambda with Gibbs sampling
    for j = 1:d
        while 1
           lambdai = gamrnd(2, theta);
           p 
           if u <= p
               break;
           end
        end
    end
    %Draw new t with Metropolis-Hastings
    tnew = t;
    for b = 2:d
       R = rho*(t(b+1)-t(b-1));
       tnew(b) = t(b) + (2*rand-1)*R;
    end
    r_tGiven_tnew = (0.5/R)^(d-1);
    r_tnewGiven_t = (0.5/R)^(d-1);
    alpha = min(1, f_t(tnew, lambda, tau)*r_tGiven_tnew/(f_t(t,lambda,tau)*r_tnewGiven_t)); %f_t is probably not correct
    if (rand <= alpha)
       t = tnew; 
    end
   
end