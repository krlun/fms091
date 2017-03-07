function [ u ] = F_inv(x, beta, mu)
%F_INV calculates the inverse of the Gumbel distribution.
    u = mu - beta*log(-log(x));

end

