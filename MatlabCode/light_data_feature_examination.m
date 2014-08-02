clear;
close all

% load light_ft_20140505_600.mat

load light_ft_20140512_900.mat

% load movie_ft_20140427.mat

%% two classes
mode = '4cls';

if strcmp(mode, '2cls')
    % replace class-labels
    idx12 = (class_label <= 2);
    idx34 = (class_label >= 3);

    class_label(idx12) = 1;
    class_label(idx34) = 2;
end

%%
n_fea = length(fea_name);
uni_class_label = unique(class_label);
n_class= length(uni_class_label);

if strcmp(mode, '4cls')
    my_color = {'r-x', 'g->', 'm-+', 'b-o', 'c-s', 'k-d'};
elseif strcmp(mode, '2cls')
    my_color = {'g->', 'b-o'};
end

for i = 1:n_fea
%     figure;
%     hold on
%     for j = 1:n_class
%         cur_idx = (class_label == uni_class_label(j));
%         cur_fea = fea_mat(cur_idx, i);
%         plot(j, cur_fea, my_color{j}, 'linewidth', 1.5);
%     end
%     xlim([0 n_class + 1]);
%     ylabel(fea_name{i});
%     grid on
%     hold off
    
    % cdf
    my_figure(1.2/2.8,1.2/4.5);
    % figure;
    hold on
    for j = 1:n_class
        cur_idx = (class_label == uni_class_label(j));
        cur_fea = fea_mat(cur_idx, i);
        [f,x]= ecdf(cur_fea);
        plot(x, f, my_color{j}, 'linewidth', 1.5);
        if strcmp(fea_name{i}, 'Range')
            xlim([0 0.6]);
        elseif strcmp(fea_name{i}, 'Skewness')
            xlim([-10 10]);
        elseif strcmp(fea_name{i}, 'Kurtosis')
            xlim([0 100]);
        end
    end
    xlabel(fea_name{i}, 'fontsize', 18);
    ylabel('Empirical CDF', 'fontsize', 18);
%     legend('Action', 'Adventure', 'Animation', 'Comedy', 'Sci-Fi');
    if strcmp(mode, '4cls')
        legend('Webpage', 'Code', 'Game', 'Video');
    elseif strcmp(mode, '2cls')
        legend('Non-Media', 'Media');
    end
    set(gca, 'fontsize', 18);
    grid on
    hold off
    
end
