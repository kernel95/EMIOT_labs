function distortion = distortion(difference, W, H)
    
    distortion = (difference / (W * H * sqrt(100.^2 + 255.^2 + 255.^2))) * 100;

end