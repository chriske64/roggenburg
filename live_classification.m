clear;

%% Select camera
camera = 'internal'; %set either to 'phone' or 'internal'


if strcmp(camera,'phone')
cam = webcam(1);
% note: resolution = '480x640';
elseif strcmp(camera,'internal')
cam = webcam(2);
% note: resolution = '1280x720';
end

%% Load trained weights W
learned_W = matfile('saveW.mat');
W = learned_W.W;

figure;
%%
while true

pic = cam.snapshot();

pic_segm = rgb2gray(pic);


if strcmp(camera,'internal')
pic_segm = imcrop(pic_segm,[390,60,500,500]);
pic_segm = imresize(pic_segm, [28,28]);


elseif strcmp(camera,'phone')
pic_segm = imcrop(pic_segm,[120,50,400,400]);
end


pic_segm = imcomplement(pic_segm);
pic_segm = imadjust(pic_segm);
pic_segm = thresholding(double(pic_segm),130);

pic_segm = normalize(pic_segm, 0.3)./255;

probs = pic_segm'*W;
[maxprob,label] = max(probs);
probs = exp(probs)/sum(exp(probs));


subplot(1,3,1);
imshow(pic);
hold on;
if strcmp(camera, 'internal')
rectangle('Position', [390,60,500,500], 'LineWidt',4, 'Edgecolor','r' );
elseif strcmp(camera, 'phone')
rectangle('Position', [120,50,400,400], 'LineWidt',4, 'Edgecolor','r' );
end
subplot(1,3,2);
imshow(reshape(pic_segm, [28,28]));
title(['This is a ', num2str(label-1), ' with probability ', num2str(probs(label)*100), '%']);
subplot(1,3,3);
bar(0:1:9,100*probs);
title('Probabilities');
drawnow;

end