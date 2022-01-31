%% luminance reduction 
function hist_eq_img = histogram_eq(img)

    %figure;
    %imhist(img);
    
    hist_eq_img = histeq(img);

    %figure;
    %imhist(hist_eq_img);
    figure2 = figure;
    imshow(hist_eq_img);
    saveas(figure2, 'figures/HistoEq_manipulation_result.jpg');
end