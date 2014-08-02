clear;
close all

% 100
% 0.0034 +/- 0.0052
% = 0.0086
% 
% 300
% 0.0018 +/- 0.0027
% = 0.0045
% 
% 600
% 0.0012+/-0.0017
% = 0.0029
% 
% 900
% 9*10-4 +/- 0.0013
% = 0.0022
% 
% 1200
%
%     %%
%     if win_size == 600
%         change_thre = 0.02;
%         idx_up = (frag_diff >= change_thre);
%         idx_down = (frag_diff <= -change_thre);
%         idx_change = (idx_up - idx_down);
%         stairs((1:length(frag))/10,[0 idx_change.'].*frag.', 'r');
%     end
    
%% class-specific pre, rec, F
%% 2cls
% dt class 1,2,3,4
pre = [...
0.9507    0.9479 % 100
0.9440    0.9440 % 300
0.9720    0.9512 % 600
0.9676    0.9662 % 900
0.9846    0.9623 % 1200
];

rec = [ ...
0.9543    0.9439 % 100
0.9518    0.9350 % 300
0.9586    0.9669 % 600
0.9728    0.9597 % 900
0.9697    0.9808 % 1200
];

F = [ ...
0.9525    0.9459 % 100
0.9479    0.9395 % 300
0.9653    0.9590 % 600
0.9702    0.9630 % 900
0.9771    0.9714 % 1200
];


%% 4cls

%% dt % class 1 2 3 4 - only a few games
% pre = [ ...
% 0.5791    0.5789    0.4017    0.7350 % 100
% 0.6101    0.6798    0.4737    0.7690 % 300
% 0.6824    0.6935    0.4932    0.7758 % 600
% 0.7143    0.7250    0.6154    0.7523 % 900
% 0.7123    0.7213    0.4516    0.6901 % 1200
% ];
% 
% rec = [ ...
% 0.5780    0.5803    0.3381    0.7957 % 100
% 0.6928    0.5741    0.3956    0.8299 % 300
% 0.7250    0.6615    0.4186    0.8205 % 600
% 0.7426    0.6988    0.4364    0.8723 % 900
% 0.7123    0.7458    0.3500    0.7656 % 1200
% ];
% 
% F = [ ...
% 0.5785    0.5796    0.3671    0.7642 % 100
% 0.6488    0.6225    0.4311    0.7983 % 300
% 0.7030    0.6772    0.4528    0.7975 % 600
% 0.7282    0.7117    0.5106    0.8079 % 900
% 0.7123    0.7333    0.3944    0.7259 % 1200
% ];

%% dt % class 1 2 3 4 - lots of games
% pre = [ ...
% 0.5243    0.5827    0.6028    0.6632 % 100
% 0.5803    0.6331    0.6603    0.7026 % 300
% 0.6463    0.7132    0.6543    0.6897 % 600
% 0.7000    0.7647    0.6337    0.6481 % 900
% 0.6522    0.6719    0.7143    0.7286 % 1200
% ];
% 
% rec = [ ...
% 0.5361    0.5659    0.5558    0.7205 % 100
% 0.6747    0.5815    0.5379    0.7830 % 300
% 0.6625    0.7077    0.5792    0.7692 % 600
% 0.6931    0.7831    0.5517    0.7447 % 900
% 0.6164    0.7288    0.6548    0.7969 % 1200
% ];
% 
% F = [ ...
% 0.5301    0.5742    0.5783    0.6907 % 100
% 0.6240    0.6062    0.5928    0.7406 % 300
% 0.6543    0.7104    0.6145    0.7273 % 600
% 0.6965    0.7738    0.5899    0.6931 % 900
% 0.6338    0.6992    0.6832    0.7612 % 1200
% ];

%% 
% %% svm_rbf classes
% pre = [ ...
% 0.6861    0.5822    0.4802    0.8006 % 100
% 0.7520    0.6563    0.3600    0.7155 % 300
% 0.7551    0.7537    0.4143    0.7182 % 600
% 0.7889    0.7882    0.4884    0.6696 % 900
% 0.8235    0.8136    0.3438    0.6104 % 1200
% ]; 
% 
% rec = [ ...
% 0.4815    0.8237    0.4964    0.7567 % 100
% 0.5753    0.8630    0.3462    0.7155 % 300
% 0.6937    0.7769    0.3372    0.8333 % 600
% 0.7030    0.8072    0.3818    0.8191 % 900
% 0.7671    0.8136    0.2750    0.7344 % 1200
% ];
% 
% F = [ ...
% 0.5659    0.6822    0.4882    0.7780 % 100
% 0.6519    0.7456    0.3529    0.7155 % 300    
% 0.7231    0.7652    0.3718    0.7715 % 600
% 0.7435    0.7976    0.4286    0.7368 % 900
% 0.7943    0.8136    0.3056    0.6667 % 1200
% ];
% 
%
dim_to_use = [1 2];
y_range = [0.5 1];
ytick_range = 0.5:0.1:1;
legend_str = {'Non-media', 'Media'};

% dim_to_use = [1 2 3 4];
% y_range = [0 0.8]; % [0 0.8]
% ytick_range = 0:0.1:0.8; % 0:0.1:0.8
% legend_str = {'Browsing', 'Coding', 'Gaming', 'Video'};

my_figure(1/2.5,1/4);
bar(F(:,dim_to_use))
legend(legend_str);
xlabel('Window size (second)', 'fontsize', 18);
ylabel('F-score', 'fontsize', 18);
xlim([0.5 5.5]);
ylim(y_range);
set(gca, 'fontsize', 18, 'XTickLabel', {'10', '30', '60', '90', '120'}, ...
    'YTick', ytick_range, 'YGrid', 'on');
colormap gray

my_figure(1/2.5,1/4);
bar(pre(:,dim_to_use))
legend(legend_str);
xlabel('Window size (second)', 'fontsize', 18);
ylabel('Precision', 'fontsize', 18);
xlim([0.5 5.5]);
ylim(y_range);
set(gca, 'fontsize', 18, 'XTickLabel', {'10', '30', '60', '90', '120'}, ...
    'YTick', ytick_range, 'YGrid', 'on');
colormap gray

my_figure(1/2.5,1/4);
bar(rec(:,dim_to_use))
legend(legend_str);
xlabel('Window size (second)', 'fontsize', 18);
ylabel('Recall', 'fontsize', 18);
xlim([0.5 5.5]);
ylim(y_range);
set(gca, 'fontsize', 18, 'XTickLabel', {'10', '30', '60', '90', '120'}, ...
    'YTick', ytick_range, 'YGrid', 'on');
colormap gray


%% 2cls
ave_pre = [ ...
    0.8647    0.8901    0.9494    0.9464    0.9537 % 100
    0.8638    0.9156    0.9440    0.9530    0.9574 % 300    
    0.8730    0.9068    0.9626    0.9514    0.9662 % 600
    0.9016    0.9419    0.9670    0.9370    0.9615 % 900
    0.8855    0.9191    0.9748    0.9237    0.9529 % 1200
];

ave_rec = [ ...
    0.8640    0.8897    0.9494    0.9454    0.9537 % 100
    0.8613    0.9156    0.9440    0.9529    0.9573 % 300
    0.8703    0.9041    0.9624    0.9511    0.9662 % 600
    0.8979    0.9399    0.9670    0.9369    0.9610 % 900
    0.8856    0.9153    0.9746    0.9237    0.9492 % 1200
];

ave_F = [ ...
    0.8636    0.8897    0.9494    0.9453    0.9537 % 100
    0.8605    0.9156    0.9440    0.9529    0.9573 % 300
    0.8694    0.9043    0.9624    0.9510    0.9662 % 600
    0.8970    0.9401    0.9670    0.9369    0.9610 % 900
    0.8854    0.9155    0.9746    0.9236    0.9493 % 1200
];


%% 4cls
% wgt = [0.3008    0.2444    0.1617    0.2932];
% 
% ave_pre = zeros(1,5);
% ave_rec = zeros(1,5);
% for i = 1:5
%     ave_pre(i) = sum(wgt.*pre(i,:));
%     ave_rec(i) = sum(wgt.*rec(i,:));
% end
% 
% ave_pre
% ave_rec

% ave_pre = [ ...
% 0.5168    0.6433    0.5961    0.6383    0.6611 % 100
% 0.5184    0.6911    0.6517    0.6560    0.6546 % 300
% 0.5251    0.6870    0.6819    0.6660    0.6889 % 600
% 0.5585    0.6924    0.7121    0.6346    0.7052 % 900
% 0.5174    0.6508    0.6659    0.6202    0.6811 % 1200
% ];
% 
% ave_rec = [ ...
% 0.5314    0.6127    0.6037    0.6396    0.6483 % 100
% 0.5398    0.6700    0.6560    0.6586    0.6497 % 300
% 0.5320    0.6711    0.6880    0.6673    0.6974 % 600
% 0.5740    0.6795    0.7205    0.6369    0.7107 % 900
% 0.5336    0.6340    0.6776    0.6209    0.6894 % 1200
% ];
% 
% ave_F = [ ...
% 0.5267    0.6183    0.6020    0.6409    0.6464 % 100
% 0.5285    0.6779    0.6526    0.6583    0.6453 % 300
% 0.5267    0.6756    0.6840    0.6661    0.6908 % 600
% 0.5567    0.6807    0.7106    0.6275    0.7031 % 900
% 0.5158    0.6304    0.6674    0.6096    0.6817 % 1200
% ];

% % new
% ave_F = [ ...
% 0.4751    0.5909    0.5949    0.6364    0.6350 % 100
% 0.5254    0.6527    0.6413    0.6706    0.6688 % 300
% 0.5170    0.6406    0.6724    0.6743    0.6765 % 600
% 0.5647    0.6388    0.6806    0.6500    0.6903 % 900
% 0.4968    0.6097    0.6915    0.6914    0.6760 % 1200
% ];

dim_to_use = [1 2 3 5];

y_range = [0.4 1]; % [0 0.8]; % 
ytick_range = 0.4:0.1:1; % 0:0.1:0.8; % 
legend_str = {'KNN', 'NB', 'DT', 'SVM'};

my_figure(1/2.5,1/4);
bar(ave_F(:,dim_to_use))
legend(legend_str);
xlabel('Window size (second)', 'fontsize', 18);
ylabel('F-score (wgt ave)', 'fontsize', 18);
xlim([0.5 5.5]);
ylim(y_range);
set(gca, 'fontsize', 18, 'XTickLabel', {'10', '30', '60', '90', '120'}, ...
    'YTick', ytick_range, 'YGrid', 'on');
colormap gray

my_figure(1/2.5,1/4);
bar(ave_pre(:,dim_to_use))
legend('KNN', 'NB', 'DT', 'SVM');
xlabel('Window size (second)', 'fontsize', 18);
ylabel('Precision (wgt ave)', 'fontsize', 18);
xlim([0.5 5.5]);
ylim(y_range);
set(gca, 'fontsize', 18, 'XTickLabel', {'10', '30', '60', '90', '120'}, ...
    'YTick', ytick_range, 'YGrid', 'on');
colormap gray

my_figure(1/2.5,1/4);
bar(ave_rec(:,dim_to_use))
legend('KNN', 'NB', 'DT', 'SVM');
xlabel('Window size (second)', 'fontsize', 18);
ylabel('Recall (wgt ave)', 'fontsize', 18);
xlim([0.5 5.5]);
ylim(y_range);
set(gca, 'fontsize', 18, 'XTickLabel', {'10', '30', '60', '90', '120'}, ...
    'YTick', ytick_range, 'YGrid', 'on');
colormap gray


