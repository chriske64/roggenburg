clc;
clear;
label='nothing';
cam = webcam;
learned_W = matfile('saveW.mat');
W = learned_W.W;

figure;

while true

pic = cam.snapshot();

picg = rgb2gray(pic);
picg = imcrop(picg,[390,60,500,500]);
picg = imresize(picg, [28,28]);
picg = imcomplement(picg);
picg = imadjust(picg);

picg = thresholding(double(picg),160);

picg =  double(reshape((picg),[28.^2,1]))/255;

probs = picg'*W;
[maxprob,label] = max(probs);
probs = exp(probs)/sum(exp(probs));


subplot(1,3,1);
imshow(pic);
hold on;
rectangle('Position', [390,60,500,500], 'LineWidt',4, 'Edgecolor','r' );
hold off;
subplot(1,3,2);
imshow(reshape(picg, [28,28]));
title(['This is a ', num2str(label-1), ' with probability ', num2str(probs(label)*100), '%']);
subplot(1,3,3);
bar(0:1:9,100*probs);
title('Probabilities');
drawnow;

end