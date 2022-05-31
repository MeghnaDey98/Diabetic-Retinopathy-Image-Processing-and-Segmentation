function segimg = segmentRetina(I)
[r,c, ~] = size(I);
B = imresize(I, [r c]);
gray = im2double(B);
%% Median Filter for removal of Salt and Pepper noise
gray=medfilt2(gray);
%% Contrast Enhancment of gray image using CLAHE
J = adapthisteq(gray,'numTiles',[8 8],'nBins',128);
%% Background Exclusion                    % Apply Average Filter
 h = fspecial('average', [9 9]);
 JF = imfilter(J, h);
 %figure, imshow(JF)
% Take the difference between the gray image and Average Filter
Z = imsubtract(JF, J);
%figure, imshow(Z);
%% Threshold using the IsoData Method
level=isodata(Z); % this is our threshold level
 %% Convert to Binary
  BW = imbinarize(Z, level);%one of the factors to play arouund
%% Remove small pixels
 BW2 = bwareaopen(BW, 100);

%% Overlay
BW2 = imcomplement(BW2);
out = imoverlay(B, BW2, [0 0 0]);
%figure, imshow(out)
           
vv = rgb2gray(out);
binaryImage = vv > 60;
                   
BW2 = bwmorph(binaryImage,'close');
BW2 = bwmorph(BW2,'close');
BW2 = bwmorph(BW2,'clean'); %post processing morphological operations
%figure, imshow(BW2);
segimg = BW2;
end