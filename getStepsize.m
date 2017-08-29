function [ t ] = getStepsize( W, sample, alpha, grad, gamma, beta, maxiter )

%   ________ Armijo-rule based stepsize ___________
%   Output: 
%   W               current weight
%   sample          sample vector 
%   grad            gradient at W
%   gamma           Parameter in Armijo condition
%   beta            Backtracking parameter
%   maxiter         maximal backtracking 
%
%
%   Correct update rule:    W_new = W + t*d   where d = - grad/norm(grad)


t = 1;
counter = 1;  
d = -grad/norm(grad); 

while ( evalLoss(W + t*d, sample,  alpha) - evalLoss(W, sample, alpha) <= - t*gamma*norm(grad, 'fro') && counter <= maxiter ) 
    t = beta*t; 
end

end

