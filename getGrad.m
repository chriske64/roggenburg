function [ gradients ] = getGrad( W, sample, alpha )
%computes the gradient of the CE-softmax functional around the weights W
%and with the input sample. Alpha is the weighting factor of the weight
%decay regulariser.

% extract raw data from inputs
f = sample(1:784,:);
label = sample(785,:);
amountData = size(sample,2);


% compute scalar product w^t *f, dim = 10 x n
scal = exp(W' * f);

% compute weighting factor
fac = scal * ones(10,1);

% initialize Variables
rawGrad = zeros(784,10, amountData);
sumGrad = zeros(784,10);

% gradients of CE
for k = 1:amountData
    rawGrad(:,:,k) = 1/fac(k) *f(:,k)* scal(:,k)';
    rawGrad(:, label(k)+1,k) = rawGrad(:, label(k)+1,k) - f(:,k);
    sumGrad = sumGrad + rawGrad(:,:,k);
    
% gradients of regulariser
gradReg = 2*amountData*W;

% overall gradient
gradients = sumGrad + alpha * gradReg;


end


