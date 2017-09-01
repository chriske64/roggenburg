function [ normalized_pic ] = normalize( pic, alpha )
%The function takes an unnormalized picture that
%contains some nonzero elements, cuts out the nonzero part, pads it in a
%picture that is alpha% bigger than the cut out part and quadratic. The
%output picture is reshaped to 28x28

% cut out sharply at figure borders
size = shape(pic);
contracted_v = pic * ones(size(2),1);
[upper, lower] = borders(contracted_v);
contracted_h = pic' * ones(size(1),1);
[left, right] = borders(contracted_h);
pruned_pic = pic(upper:lower, left:right);
pruned_size = shape(pruned_pic);

% ensure cut picture has minimum size
if max(pruned_size)<28
    pruned_pic = zeros(28,28);
    pruned_size = shape(pruned_pic);
end

% Do 0-padding around sharp cut
if pruned_size(1) >= pruned_size(2)
    new_size = floor(2*alpha*pruned_size(1) + pruned_size(1));
else
    new_size = floor(2*alpha*pruned_size(2) + pruned_size(2));
end

normal_pic = zeros(new_size, new_size);
ulc = [1,1];
ulc(1) = floor((new_size - pruned_size(1))/2);
ulc(2) = floor((new_size - pruned_size(2))/2);
normal_pic(ulc(1):(ulc(1)+pruned_size(1)-1), ulc(2):(ulc(2)+pruned_size(2)-1));
normalized_pic = imresize(normal_pic, [28,28]);
end

function [first, last] = borders (vec)
len = length(vec);
first = 0;
k = 1;
while (first == 0) && (k <= len)
   if vec(k) ~= 0
      first = k; 
   end
   k = k+1;
end
last = 0;
k = len;
while (last == 0) && (k >= first)
   if vec(k) ~= 0
      last = k; 
   end
   k = k-1;
end
end