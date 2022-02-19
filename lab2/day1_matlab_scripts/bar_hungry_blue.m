function bar_hungry_blue(images_list, name_list)

    folder = "../figures_day1/";

    x_name = strings(1, length(images_list));
    y_power_cons_blue1 = zeros(1, length(images_list.power_hungry_blue1));
    y_power_cons_blue5 = zeros(1, length(images_list.power_hungry_blue5));
    y_power_cons_blue10 = zeros(1, length(images_list.power_hungry_blue10));
    y_hungry_blue_total = zeros(1, length(images_list.power_hungry_blue10)*3);

    x_name = categorical(images_list.name);
    x_name = reordercats(x_name);
    y_power_cons_blue1 = images_list.savings_hungry_blue1;
    y_power_cons_blue5 = images_list.savings_hungry_blue5;
    y_power_cons_blue10 = images_list.savings_hungry_blue10;

    fig_bar1 = figure;
    y_hungry_blue_total = [y_power_cons_blue1 ; y_power_cons_blue5 ; y_power_cons_blue10];
    ylabel('POWER SAVINGS');
    fig_bar1 = bar(x_name, y_hungry_blue_total);
    l = cell(1,3);
    l{1}='1%'; l{2}='5%'; l{3}='10%';
    legend(fig_bar1,l);
    ylabel('SAVINGS HUNGRY BLUE');
    ax = gca;
    saving_path = strcat(folder, '/power_savings_hungry_blue_', name_list, '.jpg');
    exportgraphics(ax, saving_path, 'resolution',600); %remember to change name to specify the list

end