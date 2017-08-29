%% load images and set up problem - nothing to be done here
images = loadMNISTImages('train-images.idx3-ubyte');
labels = loadMNISTLabels('train-labels.idx1-ubyte');
images_test = loadMNISTImages('t10k-images.idx3-ubyte');
labels_test = loadMNISTLabels('t10k-labels.idx1-ubyte');


% initial weights W
W = 0.1*randn(28*28,10);

%% Constant step size gradient descent
fprintf('______________ Constant stepsize ______________ \n');
step_size = 0.001;
regulariser_weight = 0.01;
for k = 1:300
    samples = get_samples(images, labels, 50);
    grad = getGrad(W, samples, regulariser_weight);
    W = W - step_size * grad; 
    if mod(k,10) == 0
        acc = model_eval(images_test, labels_test,W);
    end

end

Wconst = W; 

%% adaptive step size gradient descent

fprintf('_________________ Armijo stepsize ______________ \n'); 
W = 0.1*randn(28*28,10);

for k = 1:300
    samples = get_samples(images, labels, 50);
    grad = getGrad(W, samples, regulariser_weight);
    t = getStepsize( W, samples, regulariser_weight, grad, 0.9, 0.9, 100 );
    d = -grad/norm(grad,'fro');
    W = W +t*d; 
    if mod(k,10) == 0
        model_eval(images_test, labels_test,W);
    end

end

Warmijo = W;

%% linesearch for hyperparameter fitting
fprintf('______________ Hyperparameter fitting _____________ \n'); 
step_size = 0.001;

exponents = -15:1:0;
regulariser_weight = 10.^exponents;

amount_points = length(regulariser_weight);
results = zeros(amount_points,1);
for j = 1:amount_points
    for k = 1:300
        samples = get_samples(images, labels, 50);
        grad = getGrad(W, samples, regulariser_weight(j));
        W = W - step_size * grad;
    end
    results(j) = model_eval(images_test, labels_test,W);
end
figure(1)
plot(exponents, results);


%% proximal operator gradient descent


%% Test model
fprintf('__________________ Final test ___________________ \n');
fprintf('Constant stepsize: \n');
model_eval(images_test, labels_test, Wconst);
fprintf('Armijo stepsize: \n');
model_eval(images_test, labels_test, Warmijo);