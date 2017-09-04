function [ prox ] = prox_l1( W, alpha )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

prox = sign(W) .* max( abs(W) - alpha, 0);

end

