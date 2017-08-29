function [ accuracy ] = model_eval( test_set, test_labels, W )
%returns the accuracy of the current model on the test set
num_test = size(test_set, 2);
[~,predictedLabels] = max(test_set'*W,[],2);
correct = sum(((predictedLabels - test_labels -1)==0));
accuracy = correct / num_test;
disp(['The network classified ', num2str(accuracy*100),'% of the test data correctly!']);
end

