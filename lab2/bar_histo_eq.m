function bar_histo_eq(images_list)

    x_name = strings(1, length(images_list));

    x_name = categorical(images_list.name);
    x_name = reordercats(x_name);

    y_power_histo_eq = zeros(1, length(images_list.power_histo_eq));

    y_power_histo_eq = images_list.savings_histo_eq;

    fig_bar4 = figure;
    ylabel('POWER SAVINGS');
    fig_bar4 = bar(x_name, y_power_histo_eq);
    ylabel('SAVINGS HISTOGRAM EQUALIZATION');
    ax = gca;
    exportgraphics(ax, 'figures/power_savings_histo_eq_list.jpg', 'resolution',600); %remember to change name to specify the list

end