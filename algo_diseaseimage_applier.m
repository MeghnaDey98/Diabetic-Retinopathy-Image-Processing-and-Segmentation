% this script applies our segmentation routine to all the images present in
% the stare database that fit our requirement eg healthy, pdbrt or npdbrt.
% A subset of these images is then used for the classification
clc;
clear all
close all
loc_inputimage='stare dataset\';
P_DBRT_indices=table2array(readtable('P_DBRT.xlsx')); %reading indices of pdbrt images
NP_DBRT_indices=table2array(readtable('NP_DBRT.xlsx')); %reading indices of npdbrt images
for i=1:length(P_DBRT_indices) 
    %adding im in front of the file index
    inputimage_no=P_DBRT_indices(i);
    %reading the raw file and resizing
    I = imread(append(loc_inputimage,char(inputimage_no)), 'ppm');
    I = imresize(I,.8);
    figure, imshow(I);title(append('Input retina image',inputimage_no));
    input = rgb2gray(I); 
    segmented_image = segmentRetina(input); %passing the read image through the filtering routine
    figure, imshow(segmented_image);title(append('Segmented image ',inputimage_no));
    %uncomment next line to store the images instead of just viewing them
    imwrite(segmented_image,append('P_DBRT ','Segmented image ',char(inputimage_no),'.png'))
end
for i=1:length(NP_DBRT_indices)
    if i==2
        continue
    end
    %adding im in front of the file index
    inputimage_no=NP_DBRT_indices(i);
    %reading the raw file and resizing
    I = imread(append(loc_inputimage,char(inputimage_no)), 'ppm');
    I = imresize(I,.8);
    figure, imshow(I);title(append('Input retina image',inputimage_no));
    input = rgb2gray(I); 
    segmented_image = segmentRetina(input);
    figure, imshow(segmented_image);title(append('Segmented image ',inputimage_no));
    %uncomment next line to store the images instead of just viewing them
    %imwrite(segmented_image,append('NP_DBRT ','Segmented image ',char(inputimage_no),'.png'))
end
%healthy image indices
normal_indices=[30,32,76,77,80,81,82,119,120,162,163,164,170,184,190,198,199,213,216,219,231,234,235,236,237,238,239,240,241,242,243,244,245,249,252,253,254,255,278];
for i=1:length(normal_indices)
    %adding im in front of the file index
    if length(num2str(normal_indices(i)))==2
        z=append('im00',num2str(normal_indices(i)));
    else 
        z=append('im0',num2str(normal_indices(i)));
    end
    inputimage_no=z;
    %reading the raw file and resizing
    I=imread(append(loc_inputimage,num2str(inputimage_no)), 'ppm');
    I = imresize(I,.8);
    input = rgb2gray(I);
    segmented_image = segmentRetina(input); %applying the segmentation routine
    figure, imshow(segmented_image);title(append('Segmented image ',inputimage_no));
    %uncomment next line to store the images instead of just viewing them
    %imwrite(segmented_image,append('Healthy ','Segmented image ',char(inputimage_no),'.png'))
end