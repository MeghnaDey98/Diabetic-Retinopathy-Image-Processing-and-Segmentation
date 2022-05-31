function Print_all_images(nfiles, images)

figure();
for i = 1:nfiles
    subplot(7, 10, i)
    imshow(cell2mat(images(i)));
end

end
