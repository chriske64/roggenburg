function images = load_train_images(filename)

%this tool is to load the training
%use 'data/train-images-idx3-ubyte' to load the training set

fp = fopen(filename, 'rb');

magic = fread(fp, 1, 'int32', 0, 'ieee-be');
assert(magic == 2051, ['Bad magic number in ', filename, '']);

numImages = fread(fp, 1, 'int32', 0, 'ieee-be');
numRows = fread(fp, 1, 'int32', 0, 'ieee-be');
numCols = fread(fp, 1, 'int32', 0, 'ieee-be');

images = fread(fp, inf, 'unsigned char');
images = reshape(images, numCols, numRows, numImages);
images = permute(images,[2 1 3]); %now we're back in the right orientation

fclose(fp);

end
