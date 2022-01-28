function best_manipulation_under_constraint(distortion_constraint, images_list)

    k_distortion_blue1 = 0;
    k_distortion_blue5 = 0;
    k_distortion_blue10 = 0;
    min_distortion_blue1 = 0;
    min_distortion_blue5 = 0;
    min_distortion_blue10 = 0;

    k_distortion_histo_eq = 0;
    min_distortion_histo_eq = 0;

    k_distortion_custom1 = 0;
    k_distortion_custom5 = 0;
    k_distortion_custom10 = 0;
    min_distortion_custom1 = 0;
    min_distortion_custom5 = 0;
    min_distortion_custom10 = 0;

    for k = 1 : length(images_list.dir)
        	%search min distortion for 1% hungry blue
        if(images_list.distortion_hungry_blue1(k) < min_distortion_blue1 && images_list.distortion_hungry_blue1(k) < distortion_constraint)
            k_distortion_blue1 = k;
            
        end
            %search min distortion for 5% hungry blue
        if(images_list.distortion_hungry_blue5(k) < min_distortion_blue5 && images_list.distortion_hungry_blue5(k) < distortion_constraint)
            k_distortion_blue5 = k;
        end
            %search min distortion for 10% hungry blue
        if(images_list.distortion_hungry_blue10(k) < min_distortion_blue10 && images_list.distortion_hungry_blue10(k) < distortion_constraint)
            k_distortion_blue10 = k;
        end
            %search min distortion histogram equalization
        if(images_list.distortion_histo_eq(k) < min_distortion_histo_eq && images_list.distortion_histo_eq(k) < distortion_constraint)
            k_distortion_histo_eq = k;
        end

            %search min distortion for 1% custom transformation
        if(images_list.distortion_custom1(k) < min_distortion_custom1 && images_list.distortion_custom1(k) < distortion_constraint)
            k_distortion_custom1 = k;
        end
            %search min distortion for 5% custom transformation
        if(images_list.distortion_custom5(k) < min_distortion_custom5 && images_list.distortion_custom5(k) < distortion_constraint)
            k_distortion_custom5 = k;
        end
            %search min distortion for 10% custom transformation
        if(images_list.distortion_custom10(k) < min_distortion_custom10 && images_list.distortion_custom10(k) < distortion_constraint)
            k_distortion_custom10 = k;
        end

    end

    %data l'indice trovo la figura e tutti i suoi attributi e li plotto
    x_names = [images_list.name(k_distortion_blue1) ; images_list.name(k_distortion_blue5); images_list.name(k_distortion_blue10); images_list.name(k_distortion_histo_eq) ; images_list.name(k_distortion_custom1); images_list.name(k_distortion_custom5); images_list.name(k_distortion_custom10)];
    
    x_names = categorical(x_names);
    x_names = reordercats(x_names);

    y_values_distortion = [images_list.distortion_hungry_blue1(k_distortion_blue1) , images_list.distortion_hungry_blue5(k_distortion_blue5) , images_list.distortion_hungry_blue10(k_distortion_blue10) , images_list.distortion_histo_eq(k_distortion_histo_eq) , images_list.distortion_custom1(k_distortion_custom1) , images_list.distortion_custom5(k_distortion_custom5) , images_list.distortion_custom10(k_distortion_custom10)];
    
    y_values_savings = [images_list.savings_hungry_blue1(k_distortion_blue1) , images_list.savings_hungry_blue5(k_distortion_blue5) , images_list.savings_hungry_blue10(k_distortion_blue10) , images_list.savings_histo_eq(k_distortion_histo_eq) , images_list.savings_custom1(k_distortion_custom1) , images_list.savings_custom5(k_distortion_custom5) , images_list.savings_custom10(k_distortion_custom10)];
    
    fig_bar1 = figure;
    y_compress = [y_values_distortion ; y_values_savings];
    ylabel('Distortion and savings');
    fig_bar1 = bar(x_names, y_compress);
    l = cell(1,2);
    l{1}='Distortion'; l{2}='Savings';
    legend(fig_bar1,l);
    ylabel('Distortion and savings');
    %ax = gca;
    %exportgraphics(ax, 'figures/power_savings_hungry_blue_list.jpg', 'resolution',600); %remember to change name to specify the list


end