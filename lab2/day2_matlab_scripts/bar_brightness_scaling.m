%function bar_brightness_scaling(images_list, name_list)

    %%
    folder = "../figures";

    x_name = strings(1, length(images_list1.dir));

    x_name = categorical(images_list1.name);
    x_name = reordercats(x_name);
    y_savings_per_photos_saturated = zeros(39,5);


    for k = 1 : length(images_list1.dir)
        y_savings_per_photos_saturated(k) = double(images_list1.savings_brightness_scaling_saturated(k).transf);
    end


    %%
    %fig_bar5 = figure;
    %y_custom_total = [y_power_cons_custom1 ; y_power_cons_custom5 ; y_power_cons_custom10];
   % ylabel('POWER SAVINGS');
   % fig_bar5 = bar(x_name, images_list1.savings_brightness_scaling_saturated.transf);
   % l = cell(1,5);
    %l{1}='10V'; l{2}='11V'; l{3}='12V'; l{4}='13V'; l{5}='14V';
    %legend(fig_bar5,l);
   % ylabel('SAVINGS DVS BRIGHTNESS SCALING COMPENSATION');
    %ax = gca;
    %plot(fig_bar5);
    %saving_path = strcat(folder, 'power_savings_brightness_scaling_', name_list, '.jpg');
    %exportgraphics(ax, saving_path, 'resolution',600); %remember to change name to specify the list

%end