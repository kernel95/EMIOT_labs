function Ipanel = Ipanel(image, Vdd)

% Constant Parameters
p1 = 4.251e-5;
p2 = -3.029e-4;
p3 = 3.024e-5;
[H, W, channels] = size(image);
i_cell = zeros (H, W, 3);
R = image(:,:,1);
G = image(:,:,2);
B = image(:,:,3);

for i = 1 : H
    for j = 1 : W
        R_component = double(R(i,j));
        G_component = double(G(i,j));
        B_component = double(B(i,j));

        iR = ((p1*Vdd*double(R_component))/255) + (((p2*double(R_component)))/255) + p3;
        iG = ((p1*Vdd*double(G_component))/255) + (((p2*double(G_component)))/255) + p3;
        iB = ((p1*Vdd*double(B_component))/255) + (((p2*double(B_component)))/255) + p3;

       if iR >= 0
            i_cell(i, j, 1) = iR;
       else
            i_cell(i, j, 1) = 0;
       end
            
       if iG >= 0
            i_cell(i, j, 2) = iG;
       else
            i_cell(i, j, 2) = 0;
       end
            
       if iB >= 0
            i_cell(i, j, 3) = iB;
       else
            i_cell(i, j, 3) = 0;
       end

    end

end

Ipanel = i_cell;

end
