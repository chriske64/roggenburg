clc;
clear;
label='nothing';
cam = webcam;
learned_W = matfile('saveW.mat');
W = learned_W.W;

figure;

while true

pic = cam.snapshot();
%pic2 = insertShape(pic, 'Rectangle',[390,60,500,500]);

picg =  double(rgb2gray(pic));
picg = imcrop(picg,[390,60,500,500]);
pict = thresholding(picg,100);
pict = imcomplement(pict);


subplot(2,1,1);
imshow(pic);
hold on;
rectangle('Position', [390,60,500,500], 'LineWidt',4, 'Edgecolor','r' );
hold off;
subplot(2,1,2);
imshow(pict);
drawnow;

end