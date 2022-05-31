% This script calculates the evaluation metrices for the classifiers both
% healthy vs non healthy as well as dbrt vs npdbrt
clc
clear all
close all
%%
%healthy vs non healthy classification
healthyimagefiles = dir('Healthysubset/*.png'); %location of segmented healthy images
healthyfiles = length(healthyimagefiles); %counting the legnth
counthealthy=zeros(1,healthyfiles); %vector for counting no of segmented pixels 
for ii=1:healthyfiles
   currentfilename = healthyimagefiles(ii).name; %generating filename
   currentimage = imread(append('Healthysubset/',currentfilename)); %reading the segmented image file
   counthealthy(ii)=sum(currentimage(:) == 1); %couting no of segmented pixels
end
pdbrtimagefiles = dir('P_DBRT Imagessubset/*.png');  %location of segmented pdbrt images     
countunhealthy=zeros(1,40); %vector for counting no of segmented pixels 
for ii=1:20
   currentfilename = pdbrtimagefiles(ii).name; %generating filename
   currentimage = imread(append('P_DBRT Imagessubset/',currentfilename)); %reading the segmented image file
   countunhealthy(ii)=sum(currentimage(:) == 1); %%counting no of segmented pixels
end

npdbrtimagefiles = dir('NP_DBRT Imagessubset/*.png'); %location of npdbrt images
for ii=21:40
   currentfilename = npdbrtimagefiles(ii-20).name; %generating file name
   currentimage = imread(append('NP_DBRT Imagessubset/',currentfilename)); %reading the segmented image file
   countunhealthy(ii)=sum(currentimage(:) == 1); % %counting no of segmented pixels
end
threshold=30000; %setting the threshold
%calculating evaluation metrics
tn=sum(counthealthy(:) <threshold);
fp=sum(counthealthy(:) >threshold);
tp=sum(countunhealthy(:) >threshold);
fn=sum(countunhealthy(:) <threshold);
sensitivity=tp/ (tp + fn)
specificity= tn/ (tn + fp)
accuracy=(tp+tn) /(tp+tn+fp+fn)
%%
%prliferative vs non proliferative diabetic retinopathy classification
clear all
close all
pdbrtimagefiles = dir('P_DBRT Imagessubset/*.png');  %reading pdbrt images    
pdbrtfiles = length(pdbrtimagefiles);
countpdbrt=zeros(1,pdbrtfiles); %vector for storing the pdbrt image segmented area count
for ii=1:pdbrtfiles %loop for calculating segmented pixel count in each image
   currentfilename = pdbrtimagefiles(ii).name;
   currentimage = imread(append('P_DBRT Imagessubset/',currentfilename));
   countpdbrt(ii)=sum(currentimage(:) == 1);
end

npdbrtimagefiles = dir('NP_DBRT Imagessubset/*.png'); %reading npdbrt images
npdbrtfiles = length(npdbrtimagefiles); %for loop length
countnpdbrt=zeros(1,npdbrtfiles); %vector for storing the npdbrt image segmented area count
for ii=1:npdbrtfiles %loop for calculating segmented pixel count in each image
   currentfilename = npdbrtimagefiles(ii).name;
   currentimage = imread(append('NP_DBRT Imagessubset/',currentfilename));
   countnpdbrt(ii)=sum(currentimage(:) == 1);
end

threshold=53000; %setting the threshold
%calculation of evaluation metrics
tnpdbrt=sum(countnpdbrt(:) <threshold)*5
fnpdbrt=sum(countnpdbrt(:) >threshold)*5
tpdbrt=sum(countpdbrt(:) >threshold)*5
fpdbrt=sum(countpdbrt(:) <threshold)*5