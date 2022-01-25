function RGB_distribution(imgRGB)
   
    R = imgRGB(:, :, 1);
    G = imgRGB(:, :, 2);
    B = imgRGB(:, :, 3);
    
    histogram(R, 'FaceColor', 'r');
    hold on;
    histogram(G, 'FaceColor', 'g');
    hold on;
    histogram(B, 'FaceColor', 'b');
    legend('Red', 'Green', 'Blue');
    
    end 