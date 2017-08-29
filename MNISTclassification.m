%% load images and set up problem - nothing to be done here
images = loadMNISTImages('train-images.idx3-ubyte');
labels = loadMNISTLabels('train-labels.idx1-ubyte');
images_test = loadMNISTImages('t10k-images.idx3-ubyte');
labels_test = loadMNISTLabels('t10k-labels.idx1-ubyte');


% initial weights W
W = 0.1*randn(28*28,10);

%% Constant step size gradient descent
step_size = 0.001;
regulariser_weight = 0.01;

for k = 1:100
    samples = get_samples(images, labels, 50);
    grad = getGrad(W, samples, regulariser_weight);
    W = W - step_size * grad; 
    if mod(k,10) == 0
        model_eval(images_test, labels_test,W);
    end

end

%% adaptive step size gradient descent


%% proximal operator gradient descent


%% Test model
model_eval(images_test, labels_test, W)
