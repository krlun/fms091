function [ u ] = F_inv(x, beta, mu)
%F_INV Summary of this function goes here
%   Detailed explanation goes here
    u = mu - beta*log(-log(x));

end

