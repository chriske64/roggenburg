clear;
clc;
label = 1;
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
learned_W = matfile('W.mat');
W = learned_W.W;


%% Needed for keyboard input

set(gcf,'CurrentCharacter','@');

%% Main while loop
while true
    pause(0.3); %if we did not pause, it might lead to an error due to too many camera requests
    figure(1),clf
    pic = cam.snapshot();
    
    pic_segm = rgb2gray(pic); %convert to grayscale
    
    
    if strcmp(camera,'internal')
        pic_segm = imcrop(pic_segm,[390,60,500,500]);
        
        
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
    
    %% Plot
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
    k=get(gcf,'CurrentCharacter');
    if k~='@' % has it changed from the dummy character?
        set(gcf,'CurrentCharacter','@'); % reset the character
        
        if k==' ' %press space
            playNumberSound(label-1);
        elseif k=='p' %play phantasy name 'droelf'
            playNumberSound(10);
        end
    end
end