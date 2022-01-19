%% luminance reduction 
function hist_eq_img = histogram_eq(img)

    figure;
    imhist(img);
    
    hist_eq_img = histeq(img);

    figure;
    imhist(hist_eq_img);
end