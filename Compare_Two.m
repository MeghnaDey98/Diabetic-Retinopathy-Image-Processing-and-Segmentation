function Compare_Two(Image1, Image2, i)
    figure()
    subplot(1, 2, 1)
    imshow(cell2mat(Image1(i)))
    subplot(1, 2, 2)
    imshow(cell2mat(Image2(i)))
end