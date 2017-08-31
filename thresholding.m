function [ newimage ] = thresholding( image, threshold )
%Takes image and performs a hard threshold

newimage = image.* heaviside(image - threshold);

end

