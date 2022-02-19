function best_manipulation_under_constraint(distortion_constraint, images_list, name_list)
    folder = "../figures_day1/";

    k_image_blue1 = 0;
    k_image_blue5 = 0;
    k_image_blue10 = 0;
    min_energy_blue1 = 0;
    min_energy_blue5 = 0;
    min_energy_blue10 = 0;

    k_image_histo_eq = 0;
    min_energy_histo_eq = 0;

    k_image_custom1 = 0;
    k_image_custom5 = 0;
    k_image_custom10 = 0;
    min_energy_custom1 = 0;
    min_energy_custom5 = 0;
    min_energy_custom10 = 0;

    for k = 1 : length(images_list.dir)
        	%search min distortion for 1% hungry blue
        if(images_list.savings_hungry_blue1(k) > min_energy_blue1 && images_list.distortion_hungry_blue1(k) < distortion_constraint)
            k_image_blue1 = k;
            min_energy_blue1 = images_list.savings_hungry_blue1(k);
            
        end
            %search min distortion for 5% hungry blue
        if(images_list.savings_hungry_blue5(k) > min_energy_blue5 && images_list.distortion_hungry_blue5(k) < distortion_constraint)
            k_image_blue5 = k;
            min_energy_blue5 = images_list.savings_hungry_blue5(k);
        end
            %search min distortion for 10% hungry blue
        if(images_list.savings_hungry_blue10(k) > min_energy_blue10 && images_list.distortion_hungry_blue10(k) < distortion_constraint)
            k_image_blue10 = k;
            min_energy_blue10 = images_list.savings_hungry_blue10(k);
        end
            %search min distortion histogram equalization
        if(images_list.savings_histo_eq(k) > min_energy_histo_eq && images_list.distortion_histo_eq(k) < distortion_constraint)
            k_image_histo_eq = k;
            min_energy_histo_eq = images_list.savings_histo_eq(k);
        end

            %search min distortion for 1% custom transformation
        if(images_list.savings_custom1(k) > min_energy_custom1 && images_list.distortion_custom1(k) < distortion_constraint)
            k_image_custom1 = k;
            min_energy_custom1 = images_list.savings_custom1(k);
        end
            %search min distortion for 5% custom transformation
        if(images_list.savings_custom5(k) > min_energy_custom5 && images_list.distortion_custom5(k) < distortion_constraint)
            k_image_custom5 = k;
            min_energy_custom5 = images_list.savings_custom5(k);
        end
            %search min distortion for 10% custom transformation
        if(images_list.savings_custom10(k) > min_energy_custom10 && images_list.distortion_custom10(k) < distortion_constraint)
            k_image_custom10 = k;
            min_energy_custom10 = images_list.savings_custom10(k);
        end

    end

    %k_image_blue1
    %k_image_blue5
    %k_image_blue10
    %k_image_histo_eq
    %k_image_custom1
    %k_image_custom5
    %k_image_custom10

    %givend the index i will collect informations from the list
    %x_names = [images_list.name(k_image_blue1) , images_list.name(k_image_blue5), images_list.name(k_image_blue10), images_list.name(k_image_histo_eq) , images_list.name(k_image_custom1), images_list.name(k_image_custom5), images_list.name(k_image_custom10)];
    
    %x_names = categorical(x_names);
    %x_names = reordercats(x_names);
    
    x_names = [1, 2, 3, 4, 5, 6 ,7];
    
    y_values_savings = [images_list.savings_hungry_blue1(k_image_blue1) , images_list.savings_hungry_blue5(k_image_blue5) , images_list.savings_hungry_blue10(k_image_blue10) , images_list.savings_histo_eq(k_image_histo_eq) , images_list.savings_custom1(k_image_custom1) , images_list.savings_custom5(k_image_custom5) , images_list.savings_custom10(k_image_custom10)];
    

    fig_bar1 = figure;
    %y_compress = [y_values_distortion ; y_values_savings];
    fig_bar1 = bar(x_names, diag(y_values_savings));
    l = cell(1,7);
    l{1}='blue 1%'; l{2}='blue 5%'; l{3}='blue 10%' ; l{4}='histo eq' ; l{5}='custom 1%' ; l{6}='custom 5%' ; l{7}='custom 10%';
    legend(fig_bar1,l);
    ylabel('Energy savings within 3% distortion');
    ax = gca;
    set(ax,'xticklabel',[])
    saving_path = strcat(folder, '/best_manipulations_', name_list, '.jpg');
    exportgraphics(ax, saving_path, 'resolution',600); %remember to change name to specify the list


end