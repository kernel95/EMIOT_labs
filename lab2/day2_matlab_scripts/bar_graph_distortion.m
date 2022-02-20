function bar_graph_distortion(images_list,result_struct, name_list)

    
    folder = "../figures_day2/";

    x_name = strings(1, length(images_list.dir));

    x_name = categorical(images_list.name);
    x_name = reordercats(x_name);
    
    result_struct = result_struct / 10;
    result_struct = result_struct / 10; %they are the  same
      
    fig_bar5 = figure;
    
    fig_bar5 = bar(x_name, result_struct);
    l = cell(1,5);
    l{1}='10V'; l{2}='11V'; l{3}='12V'; l{4}='13V'; l{5}='14V';
    legend(fig_bar5,l);
    ylabel('DISTORTION');
    title('DISTORTION BRIGHTNESS SCALING AND DVS');
    %save image
    ax = gca;
    saving_path = strcat(folder, 'distortion_brightness_', name_list, '.jpg');
    exportgraphics(ax, saving_path, 'resolution',600); %remember to change name to specify the list

end