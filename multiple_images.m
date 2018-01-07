%This function reads the images from a folder. Change the folder path in
%both places in this program. The images will be 50 x 50 size after some
%image processing. If multiple folders are to be read, then the folder
%needs to be changed everytime.
clc
image_folder = 'C:\Users\Nitin\Documents\IISC 2014 Opencl\Metacognitive Neural Networks\English\Hnd\Img\Sample036'; %  Enter name of folder from which you want to upload pictures with full path

filenames = dir(fullfile(image_folder, '*.png'));  % read all images with specified extention, its jpg in our case
 total_images = numel(filenames);    % count total number of photos present in that folder
cd('C:\Users\Nitin\Documents\IISC 2014 Opencl\Metacognitive Neural Networks\English\Hnd\Img\Sample036');

 tmp = imread(filenames(1).name); 
 [r c p] = size(tmp);
 our_images_a = zeros(r,c,p,total_images);
 gray = zeros(r,c,total_images);
 small = zeros(50,50,total_images);
 newbinary = zeros(50,50,total_images);
for n = 1:total_images
     

 temp = imread(filenames(n).name);                 % Read images  
 our_images_a(:,:,:,n) = temp;
 gray(:,:,n) = rgb2gray(our_images_a(:,:,:,n));
 binary_a(:,:,n) = im2bw(gray(:,:,n));
 %now to remove as many unnecessary white pixels

 
 tmp3 = RemoveWhitePixels(r,c,binary_a,n);
 

newbinary(:,:,n) = imresize(tmp3, [50,50]);


 
end