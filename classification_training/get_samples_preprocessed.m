function [ samples ] = get_samples_preprocessed(images, labels, amount, learn_preprocessing)
%get_samples Takes as an input amout of samples to produce and the images and labels. The input of images is 28^2 x [amout of train/test images]. Outputs samples
%in format R^(28^2 +1) x R^amout

%initialize variable
samples = zeros(28.^2+1,amount);

if amount > size(images,2)
    print('ERROR, you cannot choose that many samples')
else

which_samples = randperm(size(images,2),amount);
images = images(:,which_samples);
if learn_preprocessing == true
    images = reshape(images,[28,28,amount]);
    images = uint8(255*images);
    images = imreshape();
end
labels = labels(which_samples,:);
samples(1:28^2,:) = images;
samples(28.^2 +1,:) = labels;
    
end

end

