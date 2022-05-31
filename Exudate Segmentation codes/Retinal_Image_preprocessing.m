% Get list of all BMP files in this directory
% DIR returns as a structure array.  You will need to use () and . to get
% the file names.
imagefiles = dir('*.ppm');

nfiles = length(imagefiles);    % Number of files found

for ii=1:nfiles
   currentfilename = imagefiles(ii).name;
   currentimage = imread(currentfilename);
   Orig_Images{ii} = currentimage;
end

Print_all_images(nfiles, Orig_Images);


%% Resize the image (Standard resolution of 512x512)

for i = 1:nfiles
    Im = imresize(cell2mat(Orig_Images(i)), [512 512]);  % or use im2double
    Images_Resize{i}(:,:,:) = Im;
end

% Print_all_images(nfiles, Images_Resize);
%Compare_Two(Orig_Images, Images_Resize, 15);
%% Image normalisation/ Colour intensity normalization 

for i = 1:nfiles
    Im = rescale(cell2mat(Images_Resize(i)));
    Images_Norm{i}(:,:,:) = Im;
end

% Print_all_images(nfiles, Images_Norm);
%Compare_Two(Images_Resize, Images_Norm, 37);

%% extract green channel

for i = 1:nfiles
    Im = cell2mat(Images_Norm(i));
    Images_G{i} = Im(:,:,2);
end

% Print_all_images(nfiles, Images_G);
%Compare_Two(Images_Norm, Images_G, 37);

%% contrast enhancement 
% median filter
for i = 1:nfiles
    Im = medfilt2(cell2mat(Images_G(i)));
    Images_Med{i} = Im;
end

% Print_all_images(nfiles, Images_Med);
%Compare_Two(Images_G, Images_Med, 37);

%% CLAHE
for i = 1:nfiles
    Im = adapthisteq(cell2mat(Images_Med(i)),'Range', 'original','clipLimit',0.001,'Distribution','uniform');
    Images_CLAHE{i} = Im;
end

% Print_all_images(nfiles, Images_CLAHE);
%Compare_Two(Images_Med, Images_CLAHE, 48);

%% Adjust image intensity values or colormap.

for i = 1:nfiles
    Im = imadjust(cell2mat(Images_CLAHE(i)));
    Images_Ad{i} = Im;
end

% Print_all_images(nfiles, Images_Ad);
%Compare_Two(Images_CLAHE, Images_Ad, 48);
%% Gaussian Filter
for i = 1:nfiles
    Im = imgaussfilt(cell2mat(Images_Ad(i)));
    %Im = imsharpen(Im);
    Images_Gaus{i} = Im;
end

%Print_all_images(nfiles, Images_Gaus);
%Compare_Two(Images_Ad, Images_Gaus, 48);

%% Fix uneven illumination - challenge
%% morphological bottom-hat transformation
for i = 1:nfiles
    
    C = imbothat(cell2mat(Images_Gaus(i)),strel('disk',1));
    H = imtophat(cell2mat(Images_Gaus(i)),strel('disk',80));
    Im = H - C;
    
    Images_TBH{i} = Im;
end
%Compare_Two(Images_Gaus, Images_TBH, 17);

%% Another Adjust image intensity values or colormap.

for i = 1:nfiles
    Im = imadjust(cell2mat(Images_TBH(i)));
    
    im = imcrop(cell2mat(Images_CLAHE(i)),[100 100 300 300]) ;
    if((max(im(:)) - min(im(:))) > 0.485)
        Im = im2bw(Im,(max(Im(:)) - (max(Im(:))*0.3)));
    else 
        Im = im2bw(Im,1);
    end
    
    Images_TBH_Ad{i} = Im;
end

% Print_all_images(nfiles, Images_Ad);
%Compare_Two(Images_CLAHE, Images_TBH_Ad, 4);

Overlay_E(Images_Resize, Images_TBH_Ad, 1, nfiles);