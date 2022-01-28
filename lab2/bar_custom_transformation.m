function bar_custom_transformation(images_list)

    x_name = strings(1, length(images_list));

    x_name = categorical(images_list.name);
    x_name = reordercats(x_name);

    y_power_cons_custom1 = zeros(1, length(images_list.power_custom1));
    y_power_cons_custom5 = zeros(1, length(images_list.power_custom5));
    y_power_cons_custom10 = zeros(1, length(images_list.power_custom10));
    y_hungry_custom_total = zeros(1, length(images_list.power_custom10)*3);

    y_power_cons_custom1 = images_list.savings_custom1;
    y_power_cons_custom5 = images_list.savings_custom5;
    y_power_cons_custom10 = images_list.savings_custom10;

    fig_bar5 = figure;
    y_custom_total = [y_power_cons_custom1 ; y_power_cons_custom5 ; y_power_cons_custom10];
    ylabel('POWER SAVINGS');
    fig_bar5 = bar(x_name, y_custom_total);
    l = cell(1,3);
    l{1}='1%'; l{2}='5%'; l{3}='10%';
    legend(fig_bar5,l);
    ylabel('SAVINGS CUSTOM TRANSFORMATION');
    ax = gca;
    exportgraphics(ax, 'figures/power_savings_custom_list.jpg', 'resolution',600); %remember to change name to specify the list

end