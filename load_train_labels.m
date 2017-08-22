function labels = load_train_labels(filename)

%this tool is to load the training
%use 'data/train-labels-idx1-ubyte' to load the training set

fp = fopen(filename, 'rb');


magic = fread(fp, 1, 'int32', 0, 'ieee-be');
assert(magic == 2049, ['Bad magic number in ', filename, '']);

numLabels = fread(fp, 1, 'int32', 0, 'ieee-be');
labels = fread(fp, inf, 'unsigned char');
assert(size(labels,1) == numLabels, 'Mismatch in label count');
fclose(fp);

end