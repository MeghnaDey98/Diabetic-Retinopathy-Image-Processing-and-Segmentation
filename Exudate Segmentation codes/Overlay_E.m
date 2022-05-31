function Overlay_E(Image1, Image2, j, k)
    for i = j:k
        figure();
        imshow(cell2mat(Image1(i)));
        hold on;
        contour(cell2mat(Image2(i)), 'b');
        title('Detection of Hard Exudates');
    end
end