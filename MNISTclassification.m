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

end

%% adaptive step size gradient descent


%% proximal operator gradient descent


%% Test your result - nothing to do here - the code works as is
num_test = size(images_test, 2);
[~,predictedLabels] = max(images_test'*W,[],2);
correct = sum(((predictedLabels - labels_test -1)==0));
test_correct_percent = correct / num_test;
disp(['The network classified ', num2str(test_correct_percent*100),'% of the test data correctly!']);
