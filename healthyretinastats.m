%in this file we are just processing the healthy retina files for which
%ground truth images are available in the form of annotations in stare
%databse
%% sorting out the standard approach
clc;
clear all
close all
%% index generation for various cases
normal_indices=[30,32,76,77,80,81,82,108,109,119,120,162,163,164,167,170,184,190,198,199,213,216,219,231,234,235,236,237,238,239,240,241,242,243,244,2445,249,252,253,254,255,278];
gt_indices=[1,2,3,4,5,44,77,81,82,139,162,163,235,239,240,255,291,319,324];
normal_gt_indices=intersect(normal_indices,gt_indices);
normal_gt_indices=string(normal_gt_indices);
n=length(normal_gt_indices);
%% reading files from directory
z=readmatrix('stare dataset\all-mg-codes.csv');
loc_inputimage='stare dataset\';
loc_gt1='stare dataset adam\';
loc_gt2='stare dataset valentina\';
P_DBRT_indices=table2array(readtable('P_DBRT.xlsx'));
NP_DBRT_indices=table2array(readtable('NP_DBRT.xlsx'));
%% array generation for batch processing
arrP=zeros(1,n);
arrN=zeros(1,n);
arrT=zeros(1,n);
%% actual batch proecessing
for i=1:length(normal_gt_indices)
    %adding im in front of the file index
    if strlength(normal_gt_indices(i))==2
        normal_gt_indices(i)=append('im00',normal_gt_indices(i));
    else 
        normal_gt_indices(i)=append('im0',normal_gt_indices(i));
    end
 
    inputimage_no=normal_gt_indices(i);
    %reading the raw file
    I = imread(append(loc_inputimage,inputimage_no), 'ppm');
    I = imresize(I,.8);
    %figure, imshow(I);title(append('Input retina image',inputimage_no));
    input = rgb2gray(I); %need to check if green band approach gives better result
    %input=I(:,:,2);
    %reading the groundtruthfile
    gt1 = imread(append(loc_gt1,inputimage_no,'_ah'), 'ppm');
    gt1 = imresize(gt1,.8);
    gt_image = imbinarize(gt1);
    %figure, imshow(gt1);title(append('Ground truth image ',inputimage_no));
    
    
    segmented_image = segmentRetina(input); %applying the segmentation routine
    
    [P, N, T] = calculatePNT2(segmented_image,gt_image); %calculation of evaluation metrics compared to ground truth images
    arrP(i)=P;
    arrN(i)=N;
    arrT(i)=T;
    %figure, imshow(segmented_image);title(append('Segmented image ',inputimage_no));
end
%% statistics
fprintf('Value of P is : %.2f\n', mean(arrP));
fprintf('Value of N is : %.2f\n', mean(arrN));
fprintf('Value of T is : %.2f\n', mean(arrT));