%This script helps in visualising the properties of the images on which the
%classifier was designed
clc
clear all
close all
pdbrtimagefiles = dir('P_DBRT Imagessubset/*.png'); %reading pdbrt images     
pdbrtfiles = length(pdbrtimagefiles);
countpdbrt=zeros(1,pdbrtfiles); %vector for storing area segmented in each image
for ii=1:pdbrtfiles %loop for calculating segmented pixel count in each imagw
   currentfilename = pdbrtimagefiles(ii).name;
   currentimage = imread(append('P_DBRT Imagessubset/',currentfilename));
   countpdbrt(ii)=sum(currentimage(:) == 1);
end

npdbrtimagefiles = dir('NP_DBRT Imagessubset/*.png'); %reading npdbrt images
npdbrtfiles = length(npdbrtimagefiles);
countnpdbrt=zeros(1,npdbrtfiles);%vector for storing area segmented in each image
for ii=1:npdbrtfiles %loop for calculating segmented pixel count in each image
   currentfilename = npdbrtimagefiles(ii).name;
   currentimage = imread(append('NP_DBRT Imagessubset/',currentfilename));
   countnpdbrt(ii)=sum(currentimage(:) == 1);
end

healthyimagefiles = dir('Healthysubset/*.png');%reading healthy images
healthyfiles = length(healthyimagefiles);
counthealthy=zeros(1,healthyfiles);%vector for storing area segmented in each image
for ii=1:healthyfiles %loop for calculating segmented pixel count in each image
   currentfilename = healthyimagefiles(ii).name;
   currentimage = imread(append('Healthysubset/',currentfilename));
   counthealthy(ii)=sum(currentimage(:) == 1);
end

x = [counthealthy.';countnpdbrt.';countpdbrt.']; %xaxis
g = [ones(size(counthealthy)).'; 2*ones(size(countnpdbrt)).'; 3*ones(size(countpdbrt)).']; %yaxis
boxplot(x,g,'Labels',{'Healthy','Non Proliferative','Proliferative'}) %box plot
ylabel('Relative area being segmented (in no of pixels)')
xlabel('Class of Retinas')
figure
x = [counthealthy.';countnpdbrt.';countpdbrt.']; %x axis
g = [ones(size(counthealthy)).'; 2*ones(size(countnpdbrt)).'; 2*ones(size(countpdbrt)).']; %y axis
boxplot(x,g,'Labels',{'Healthy','Non Healthy'}) %boxplot
ylabel('Relative area being segmented (in no of pixels)')
ylabel('Class of Retinas')