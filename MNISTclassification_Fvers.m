%% load images and set up problem - nothing to be done here
images = loadMNISTImages('data/train-images.idx3-ubyte');
labels = loadMNISTLabels('data/train-labels.idx1-ubyte');
images_test = loadMNISTImages('data/t10k-images.idx3-ubyte');
labels_test = loadMNISTLabels('data/t10k-labels.idx1-ubyte');


% initial weights W
W = 0.1*randn(28*28,10);

%% Constant step size gradient descent
fprintf('______________ Constant stepsize ______________ \n');
step_size = 1e-3;
regulariser_weight = 1e-3;
energy1 = [];
energy2 = energy1;

for k = 1:1000
    samples = get_samples(images, labels, 50);
    grad = getGrad(W, samples, regulariser_weight);
    W = W - step_size * grad; 
    if mod(k,100) == 0
        acc = model_eval(images_test, labels_test,W);
        energy1 = [energy1, loss(W,get_samples(images, labels,size(images,2)),regulariser_weight/size(images,2))];
        energy2 = [energy2, loss(W, samples, regulariser_weight)];
    end
    
end

Wconst = W; 
save('saveW.mat','W');
figure; 
for k=1:10
    subplot(1,10,k);
    imshow(reshape(W(:,k),[28,28]));
end 

figure;
subplot(1,2,1);
plot(energy1);
title('Energy for whole training set');
subplot(1,2,2);
plot(energy2);
title('Energy for samples');

% %% adaptive step size gradient descent
% 
% fprintf('_________________ Armijo stepsize ______________ \n');
% W = 0.1*randn(28*28,10);
% 
% for k = 1:500
%     samples = get_samples(images, labels, 50);
%     grad = getGrad(W, samples, regulariser_weight);
%     t = getStepsize( W, samples, regulariser_weight, grad, 0.95, 0.95, 100 );
%     d = -grad/norm(grad,'fro');
%     W = W +t*d;
%     if mod(k,10) == 0
%         model_eval(images_test, labels_test,W);
%     end
%     
% end
% 
% Warmijo = W;
% 
%% linesearch for hyperparameter fitting
% fprintf('______________ Hyperparameter fitting _____________ \n'); 
% step_size = 0.001;
% 
% exponents = -5:0.5:2;
% regulariser_weight = 10.^exponents;
% 
% amount_points = length(regulariser_weight);
% results = zeros(amount_points,1);
% for j = 1:amount_points
%     for k = 1:300
%         samples = get_samples(images, labels, 50);
%         grad = getGrad(W, samples, regulariser_weight(j));
%         W = W - step_size * grad;
%     end
%     results(j) = model_eval(images_test, labels_test,W);
% end
% figure;
% plot(exponents, results);


%% proximal operator gradient descent


%% Test model
fprintf('__________________ Final test ___________________ \n');
fprintf('Constant stepsize: \n');
model_eval(images_test, labels_test, Wconst);
% fprintf('Armijo stepsize: \n');
% model_eval(images_test, labels_test, Warmijo);