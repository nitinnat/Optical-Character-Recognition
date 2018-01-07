%main file
%This file executes the OCR code.
%The file 'FeatureVectors.mat' is loaded. It contains the lbp,structural
%and dct features from the dataset used. Loading it saves time.
%Note: if new features are to be extracted, then uncomment the line 
%[lbp dct structural] = ExtractFeatures(megainput,50); and replace
%'megainput' with your training vector of m x n where m =no. of features
%and 'n' = number of training data points
 load('FeatureVectors.mat');
 
[filename, pathname] = uigetfile('*.jpg','Select an Image');

imrgb = imread(strcat(pathname,filename));


imhsv = rgb2hsv(imrgb);
[a b c] = size(imrgb);
h = imhsv(:,:,1);
s = imhsv(:,:,2);
v = imhsv(:,:,3);
imtool(imhsv);
clear imbin;
for i = 1:a
    for j = 1:b
        if s(i,j) < 0.30
            imbin(i,j) = 1;
        else
            imbin(i,j) = 0;
        end
    end
end
% figure,imshow(imbin);
imedge = edge(imbin, 'canny');
% figure,imshow(imedge);
erodedimage = imerode(imcomplement(imbin), ones(25,25));
finalimage = imcomplement(erodedimage);


[p q] = size(finalimage);
%RemoveWhitePixels2 function takes parameters of rowsize,columnsize and the
%binary processed matrix and returns a matrix with all the excess white
%pixels removed.
finalimage2 = RemoveWhitePixels2(p,q,finalimage);
finalimage3 = imcomplement(imdilate(imcomplement(finalimage2),ones(25,25)));
%Here image is resized to 50 x 50.
temp3 = imresize(finalimage3,[50 50]);
% figure,imshow(temp3);
tempimage = temp3(:);
% [lbp dct structural] = ExtractFeatures(megainput,50);
%This extracts the features for the test image.
[l2 d2 s2] = ExtractFeatures(tempimage,50);

%This function TrainAndTest(feature) takes the m x n matrix and splits it
%into 70% training and 30% testing samples. Note, the function is
%programmed for this particular project and should be changed specifically
%depending on the values of 70% and 30% of YOUR dataset's size.
[train,  test] = TrainAndTest(dct);


%Training labels have been formed
label_train = ones(1,38);
label_test = ones(1,17);
for i = 2:26
    label_train = horzcat(label_train, i*ones(1,38));
end

%The default classifier used is KNN-3 algorithm. If the number of nearest
%neighbours is to be changed, then change the last parameter of the knn2()
%function. If you would like to use svm function then refer multisvm2().
 class = knn2(train,label_train,d2,3);
 fprintf('The character is: ');
 char(class+64)
 
 subplot(1,2,1) , subimage(temp3) , title('Input image');
 image_folder = 'C:\Users\Nitin\Desktop\Optical Character Recognition- Nitin N\English\Hnd\Img\Display'; %  Enter name of folder from which you want to upload pictures with full path
 cd('C:\Users\Nitin\Desktop\Optical Character Recognition- Nitin N\English\Hnd\Img\Display');
 filenames = dir(fullfile(image_folder, '*.png'));
 
show = imread(filenames(class).name);
 subplot(1,2,2) , subimage(show) , title('Recognized image');
 

        
        