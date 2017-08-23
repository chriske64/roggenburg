%This is the main classifier. First, we load the training images and labels
%as well as the test images and test labels

train_images = load_train_images('data/train-images-idx3-ubyte');
train_labels = load_train_labels('data/train-labels-idx1-ubyte');

test_images  = load_train_images('data/t10k-images-idx3-ubyte');
test_labels = load_train_labels('data/t10k-labels.idx1-ubyte');