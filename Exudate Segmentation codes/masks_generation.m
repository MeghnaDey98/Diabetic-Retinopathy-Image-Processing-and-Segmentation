%% masks
imagefiles = dir('*.png');

nfiles = length(imagefiles);    % Number of files found

for ii=1:nfiles
   currentfilename = imagefiles(ii).name;
   currentimage = imread(currentfilename);
   Orig_masks{ii} = currentimage;
end
%%
%Print_all_images(nfiles, Orig_masks);
for i = 1:23
    %figure
    im = cell2mat(Orig_masks(i));
    mask = im(:,:,2);
    mask  = im2bw(mask,0.01);
    mask(1:30, :) = 1;
    mask(end-30:end, :) = 1;
    
    m = mask;
    m(mask == 1) = 0;
    m(mask == 0) = 1;
    
    %imshow(m);
    m = imresize(m, [512 512]);
    M{i} = m;
    
end
