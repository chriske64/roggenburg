%% load images and set up problem - nothing to be done here
images = load_train_images('train-images.idx3-ubyte');
labels = load_train_labels('train-labels.idx1-ubyte');
figure, imagesc(reshape(images(:,1), [28,28])); colormap gray; axis off; 

% initial weights W
W = 0.1*randn(28*28,10);

%% Implement the minimization algorithm here!


%% Test your result - nothing to do here - the code works as is
images_test = load_train_images('t10k-images.idx3-ubyte');
labels_test = load_train_labels('t10k-labels.idx1-ubyte');

num_test = size(images_test, 2);
[~,predictedLabels] = max(images_test'*W,[],2);
correct = sum(((predictedLabels - labels_test -1)==0));
test_correct_percent = correct / num_test;
disp(['The network classified ', num2str(test_correct_percent*100),'% of the test data correctly!']);
