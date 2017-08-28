function [ samples ] = get_samples( amout, str )
%get_samples Takes as an input amout of samples to produce. Outputs samples
%in format R^(28^2 +1) x R^amout

if str == 'train'

elseif str == 'test'

else
    print('Error, second element of get_samples should be string which is either train or test')
end

end

