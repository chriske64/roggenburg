function energy = loss(W,samples,alpha)
%extract sample size
amountData = size(samples,2);
if alpha ~= 0
    for i=1:amountData
        %extract one sample from samples
        onesample = samples(:,i);
        image = onesample(1:length(onesample)-1);
        label = onesample(length(onesample));
        energy =  energy + log(norm(exp(W' * image),1) - dot(image,W(:,label))) + alpha .* norm(W,'fro');
    end
else
    for i=1:amountData
        %extract one sample from samples
        onesample = samples(:,i);
        image = onesample(1:length(onesample)-1);
        label = onesample(length(onesample));
        energy =  energy + log(norm(exp(W' * image),1) - dot(image,W(:,label)));
    end
end

end