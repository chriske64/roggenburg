clc;
clear;
label='nothing';
cam = webcam;
learned_W = matfile('saveW.mat');
W = learned_W.W;

while true

pic = cam.snapshot();
c = clock;
seconds = round(c(6));
if mod(seconds,2) == 0
picg = imresize(pic, [28,28]);
picg =  double(reshape(rgb2gray(picg),[28.^2,1]))/255;
picg = imcomplement(picg);

[~,label] = max(picg' * W);
end

imshow(pic);
title(label+1);
drawnow;
end