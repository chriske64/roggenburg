clc;
clear;
label='nothing';
cam = webcam;
learned_W = matfile('saveW.mat');
W = learned_W.W;

figure;

while true

pic = cam.snapshot();
c = clock;
seconds = round(c(6));
if mod(seconds,1) == 0
picg = imresize(pic, [28,28]);
picg =  double(reshape(rgb2gray(picg),[28.^2,1]))/255;
picg = imcomplement(picg);
picg = picg.^2;

probs = picg'*W;
[maxprob,label] = max(probs);
probs = exp(probs)/sum(exp(probs));
end

subplot(1,3,1);
imshow(pic);
subplot(1,3,2);
imshow(reshape(picg, [28,28]));
title(['This is a ', num2str(label-1), ' with probability ', num2str(probs(label)*100), '%']);
subplot(1,3,3);
bar(0:1:9,100*probs);
title('Probabilities');
drawnow;

end