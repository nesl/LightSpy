clear;
close all;

fileNameSet = {'L20cmA4', 'L40cmA4', 'L60cmA4', 'L80cmA4', 'L100cmA4'};

n_file= length(fileNameSet);

win_size = 900;

% thre = 0.8;
thre = [0.5 0.55 0.6 0.65 0.7 0.75 0.8 0.85 0.9 0.95];

n_thre = length(thre);
% n_max (3) * n_file (20) for matching
n_match = 60;

%% true label is predefined and fixed
% the first 10*3 chunks should match, the last 10*3 chunks shoud not match
true_label = [ones(n_match/2, n_file); zeros(n_match/2, n_file)];
predict_label = zeros(n_match, n_thre, n_file);

true_label_all = [];
predict_label_all = [];

%% Folder names for storing templates and test files
templateFileName = 'L20cmA4new'; % fileNameSet{2};

% wrt different distances
for i = 1:n_file
    testFileName = fileNameSet{i};
    fileName = ['label_score_' templateFileName '_' testFileName '_' num2str(win_size) '_50_corr.mat'];
    load(fileName);
    
    % concatenate all tests
    true_label_all = [true_label_all; true_label(:,i)];
    
    for j = 1:n_thre
        predict_label(:,j,i) = (label_score_mat(:,3) >= thre(j));
    end
    
    predict_label_all = [predict_label_all; predict_label(:,:,i)];
    
end

%% calculate pre, rec and F
%% change wrt threshold
pre_record = zeros(n_thre, 1);
rec_record = zeros(n_thre, 1);
F_record = zeros(n_thre, 1);
acc = zeros(n_thre, 1);

for j = 1:n_thre
[~, confmtx] = confmat(2, length(true_label_all), true_label_all, [0 1], predict_label_all(:,j));
[pre0, rec0, F0, pre1, rec1, F1, wgt_ave_F] = binary_f_measure(confmtx);

pre_record(j) = pre1
rec_record(j) = rec1
F_record(j) = F1
acc(j) = sum(predict_label_all(:,j) == true_label_all)/length(true_label_all);
end

% result = [pre_record rec_record F_record];
% bar(result);

my_figure(1/2.5, 1/4);
plot(thre, pre_record, 'r-x', thre, rec_record, 'g-o', thre, F_record, 'b-v', 'linewidth', 1.5);
xlabel('Decision threshold', 'fontsize', 18);
ylabel('Metric', 'fontsize', 18);
legend('Precision', 'Recall', 'F-score');
set(gca,'fontsize',18);
xlim([0.5 0.95]);
grid;

%% change wrt distance
% fix the threshold
idx_thre = 4;
pre_record = zeros(n_file, 1);
rec_record = zeros(n_file, 1);
F_record = zeros(n_file, 1);
acc = zeros(n_file, 1);

for j = 1:n_file
[~, confmtx] = confmat(2, length(true_label(:,j)), true_label(:,j), [0 1], predict_label(:,idx_thre,j));
[pre0, rec0, F0, pre1, rec1, F1, wgt_ave_F] = binary_f_measure(confmtx);

pre_record(j) = pre1;
rec_record(j) = rec1;
F_record(j) = F1;
acc(j) = sum(predict_label(:,idx_thre, j) == true_label(:,j))/length(true_label(:,j));
end

my_figure(1/2.5, 1/4);
plot(1:n_file, pre_record, 'r-x', 1:n_file, rec_record, 'g-o', 1:n_file, F_record, 'b-v', 'linewidth', 1.5);
xlabel('Difference of distance', 'fontsize', 18);
ylabel('Metric', 'fontsize', 18);
legend('Precision', 'Recall', 'F-score');
set(gca,'fontsize',18, 'XTickLabel', {'0cm', '20cm', '40cm', '60cm', '80cm'});
grid;

%% data record - change with distance
pre_record = [0.8108    0.8056    0.7813    0.7742   0.7423];

rec_record = [0.9428    0.9207    0.8333    0.8000   0.7501];

F_record = [0.8718    0.8593    0.8065    0.7869    0.7462];

my_figure(1/2.5, 1/4);
plot(1:n_file, pre_record, 'r-x', 1:n_file, rec_record, 'g-o', 1:n_file, F_record, 'b-v', 'linewidth', 1.5);
xlabel('Distance to the display (cm)', 'fontsize', 18);
ylabel('Metric', 'fontsize', 18);
legend('Precision', 'Recall', 'F-score');
set(gca,'fontsize',18, 'XTickLabel', {'20', '40', '60', '80', '100'});
grid;


%% change wrt win size - data are manually entered

% thre = 0.8;
n_win_size = 5;

pre_record = [ ...
0.4978 % 100
0.7467 % 300
0.7821 % 600
0.8276 % 900
0.8390 % 1200
];

rec_record = [ ...
0.8552 % 100
0.8513 % 300
0.8469 % 600
0.8426 % 900
0.8540 % 1200
];

F_record = [ ...
0.6364 % 100
0.7960 % 300
0.8133 % 600
0.8401 % 900
0.8464 % 1200
];

my_figure(1/2.5, 1/4);
plot(1:n_win_size, pre_record, 'r-x', 1:n_win_size, rec_record, 'g-o', 1:n_win_size, F_record, 'b-v', 'linewidth', 1.5);
xlabel('Window size (second)', 'fontsize', 18);
ylabel('Metric', 'fontsize', 18);
legend('Precision', 'Recall', 'F-score');
set(gca,'fontsize',18, 'XTickLabel', {'10', '30', '60', '90', '120'});
grid;