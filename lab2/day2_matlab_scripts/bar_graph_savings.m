function bar_graph_savings(images_list,result_struct, name_list)

    
    folder = "../figures_day2/";

    x_name = strings(1, length(images_list.dir));

    x_name = categorical(images_list.name);
    x_name = reordercats(x_name);
    
    result_struct = result_struct / 1000;
    result_struct = result_struct / 1000; %they are the  same
      
    fig_bar5 = figure;
    
    fig_bar5 = bar(x_name, result_struct);
    l = cell(1,5);
    l{1}='10V'; l{2}='11V'; l{3}='12V'; l{4}='13V'; l{5}='14V';
    legend(fig_bar5,l);
    ylabel('SAVINGS  [W]');
    title('POWER SAVINGS COMBINED SATURATED DVS');
    %save image
    ax = gca;
    saving_path = strcat(folder, 'power_savings_combined_', name_list, '.jpg');
    exportgraphics(ax, saving_path, 'resolution',600); %remember to change name to specify the list

end