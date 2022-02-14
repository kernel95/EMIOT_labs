%% Power consumption

function power_cons = power_consumption(image)

y = 0.7755;
w0 = 1.48169521e-6;
wr = 2.13636845e-7;
wg = 1.77746705e-7;
wb = 2.14348309e-7;

%search for RGB values of the images

    R = image(:,:,1);
    G = image(:,:,2);
    B = image(:,:,3);
    P = zeros(65536,1);

    for i = 1 : (length(image(:,1,1)))
            for j = 1 : (length(image(1,:,1)))
                R_component = double(R(i,j));
                G_component = double(G(i,j));
                B_component = double(B(i,j));
                index = i.*255 + j;
                P(index) = (wr * (R_component .^ y)) + (wg * (G_component .^ y)) + (wb * (B_component .^ y));
            end
    end


power_cons = sum(P) + w0;
