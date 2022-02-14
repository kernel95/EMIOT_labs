function distortion = distortion(difference,image)
    
    [H, W, channels] = size(image);
    
    distortion = (difference / (W * H * sqrt(100.^2 + 255.^2 + 255.^2))) * 100;

end