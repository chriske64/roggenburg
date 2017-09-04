function [ newimage ] = thresholding( image, threshold_lower)
%Takes image and performs a hard threshold

newimage = image.* heaviside(image - threshold_lower);
%newimage = 255 .* heaviside(image - threshold_upper) + image.* heaviside(-image + threshold_upper);

end

