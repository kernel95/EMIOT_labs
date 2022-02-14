function Ppanel = Ppanel(Ipanel, Vdd, image)

P = zeros(1, 3);
[H, W, channels] = size(image);

for i = 1 : H
    for j = 1 : W

        P(1) = P(1) + Ipanel(i,j,1);
        P(2) = P(2) + Ipanel(i,j,2);
        P(3) = P(3) + Ipanel(i,j,3);
    end
end

P = P*Vdd;
Ppanel = P(1) + P(2) + P(3);

end

    