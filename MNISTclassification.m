%% load images and set up problem - nothing to be done here
images = loadMNISTImages('train-images.idx3-ubyte');
labels = loadMNISTLabels('train-labels.idx1-ubyte');
images_test = loadMNISTImages('t10k-images.idx3-ubyte');
labels_test = loadMNISTLabels('t10k-labels.idx1-ubyte');


% initial weights W
W = 0.1*randn(28*28,10);

%% preprocesing
image_format = size(images);
images_modified = zeros(image_format);
for k = 1:image_format(2)
   image = reshape(images(:,k), [28,28]);
   upsampled_im = imresize(image, [28*4, 28*4]);
   normed_im = normalize(upsampled_im, 0.3);
   images_modified(:,k) = normed_im;
   k
end
save('images_modified.mat', 'images_modified');

%%
image_t_format = size(images_test);
images_test_modified = zeros(image_t_format);
for k = 1:image_t_format(2)
   image = reshape(images_test(:,k), [28,28]);
   upsampled_im = imresize(image, [28*4, 28*4]);
   normed_im = normalize(upsampled_im, 0.3);
   images_test_modified(:,k) = normed_im;
   k
end
save('images_test_modified.mat', 'images_test_modified');

%% testing
number = 3
original = reshape(images_test(:,number), [28,28]);
modified = reshape(images_test_modified(:,number), [28,28]);
figure
subplot(211)
imshow(original)
subplot(212)
imshow(modified)


%% Constant step size gradient descent on modified data
step_size = 0.001;
regulariser_weight = 0.003;
for k = 1:1000
    samples = get_samples(images_modified, labels, 50);
    grad = getGrad(W, samples, regulariser_weight);
    W = W - step_size * grad; 
    if mod(k,10) == 0
        acc = model_eval(images_test_modified, labels_test,W);
    end
end
save('W.mat', 'W')

%% linesearch for hyperparameter fitting
step_size = 0.001;
regulariser_weight = 0.0005:0.0005:0.01;
amount_points = length(regulariser_weight);
results = zeros(amount_points,1);
for j = 1:amount_points
    for k = 1:1000
        samples = get_samples(images, labels, 50);
        grad = getGrad(W, samples, regulariser_weight(j));
        W = W - step_size * grad;
    end
    results(j) = model_eval(images_test, labels_test,W);
end
figure(1)
plot(regulariser_weight, results);

%% adaptive step size gradient descent


%% proximal operator gradient descent
step_size = 0.001;
regulariser_weight = 0.001;
batch_size = 50;
for k = 1:1000
    samples = get_samples(images, labels, batch_size);
    grad = getGrad(W, samples, 0);
    W = W - step_size * grad; 
    W = prox_l1(W,step_size * regulariser_weight * batch_size);
    if mod(k,10) == 0
        acc = model_eval(images_test, labels_test,W);
    end

end

%% Nesterov's accelerated gradient descent
step_size = 0.001;
regulariser_weight = 0.003;
batch_size = 50;
% Initialise variables for Nesterov's acc. gradient descent
t =1;
tp = t;
U = W;
Up = U;
for k = 1:1000
    samples = get_samples_preprocessed(images, labels, batch_size, true);
    grad = getGrad(W, samples, regulariser_weight);
    Up = W - step_size * grad; 
    tp = (1+sqrt(1+4*t.^2))/2;
    W = Up + (t-1)./tp * (Up - U);
    if mod(k,10) == 0
        acc = model_eval(images_test, labels_test,W);
    end
end


%% Test model
model_eval(images_test, labels_test, W)
