function gray_distribution(imgRGB)
   
    grey = imgRGB(:, :, 1);
    
    
    histogram(grey, 'FaceColor','black');
    hold on;
    legend('Greyscale');
    
    end 