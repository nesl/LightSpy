clear;

data_file_name = 'light_ft_20140512_900';

load([data_file_name '.mat'])

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
n_fold = 5;
idx_fold = {[1 2 11 12 18 19 29 30 31 32], [3 4 13 20 21 33 34 35 36], [5 6 14 15 22 23 37 38 39 40], ...
    [7 8 16 24 25 41 42 43], [9 10 17 26 27 28 44 45 46 47]};

% for data on 0508
% idx_fold = {[1 2 11 12 18 23 24 25 26], [3 4 13 19 27 28 29 30], [5 6 14 15 20 31 32 33 34], ...
%     [7 8 16 21 35 36 37 38], [9 10 17 22 39 40 41]};

% n_fold = 10;
% idx_fold = {[1 11 18 23 24], [2 12 25 26], [3 13 19 27 28], [4 29 30], [5 14 20 31 32], [6 15 33 34], ...
%     [7 16 21 35 36], [8 21 37 38], [9 17 22 39], [10 40 41]};

%% filtering using MCR
% energy = sum(feature_array.^2,2);
% thre = 100;
% idx_retain = (energy > thre);

mcr = fea_mat(:,3);
thre = 0;
idx_retain = (mcr > thre);

fea_mat = fea_mat(idx_retain,[1 2 3 5 6 7 8]);
class_label = class_label(idx_retain);
file_label = file_label(idx_retain);

n_inst = length(class_label); % movie_label
inst_int_idx = (1:n_inst)';

%% CV partition
% seed = 1;
% rng(seed);
% cvo = cvpartition(n_inst,'k',n_fold);

% %% you can also merge the label
% new_label = label;
% idx1 = (new_label<=4);
% idx2 = (new_label == 5);
% idx3 = (new_label == 6);
% idx4 = (new_label == 7);
% 
% new_label(idx1) = 1;
% new_label(idx2) = 2;
% new_label(idx3) = 3;
% new_label(idx4) = 4;

%% settings
label_to_use = class_label;
n_to_use = length(unique(label_to_use)); % n_class
cum_confmtx_dt = zeros(n_to_use, n_to_use);
cum_confmtx_nb = zeros(n_to_use, n_to_use);
cum_confmtx_knn = zeros(n_to_use, n_to_use);
cum_confmtx_svm = zeros(n_to_use, n_to_use);
cum_confmtx_svm_rbf = zeros(n_to_use, n_to_use);

%% record the test integer idx and predicted label
test_int_idx = [];
cum_predict_knn = [];
cum_predict_nb = [];
cum_predict_dt = [];
cum_predict_svm = [];
cum_predict_svm_rbf = [];

for iter = 1:n_fold
    % find the test files - integer
    test_file_idx = idx_fold{iter};
    % find the test instances - logical
    test_idx = ismember(file_label, test_file_idx);
    % train instances
    train_idx = ~test_idx;
    
    test_int_idx = [test_int_idx; inst_int_idx(test_idx)];
    
    % training data
    train_inst = fea_mat(train_idx,:);
    train_label = label_to_use(train_idx);

    % testing data
    test_inst = fea_mat(test_idx,:);
    test_label = label_to_use(test_idx);
    
    %% KNN
    predict_knn = knnclassify(test_inst, train_inst, train_label, 3, 'cosine'); % if not normalized, use 'cosine' similarity; otherwise, use Euclidean
    % smooth the output
    [~, confmtx_knn] = confmat(n_to_use, length(test_label), test_label, unique(label_to_use), predict_knn);
%     [pre1, rec1, F1, ave_F1, acc1] = multiple_f_measure(confmtx_knn)
    cum_confmtx_knn = cum_confmtx_knn + confmtx_knn;

    cum_predict_knn = [cum_predict_knn; predict_knn];
    
    %% NB
    nb = NaiveBayes.fit(train_inst, train_label, 'distribution', 'kernel', 'prior', 'uniform');
    [post_nb,predict_nb] = posterior(nb,test_inst,'HandleMissing','on');

    idx_nan = isnan(predict_nb);
    predict_nb(idx_nan) = 0;
    post_nb(idx_nan,:) = 0;

    [~, confmtx_nb] = confmat(n_to_use, length(test_label), test_label, unique(label_to_use), predict_nb);
%     [pre2, rec2, F2, ave_F2, acc2] = multiple_f_measure(confmtx_nb)
    cum_confmtx_nb = cum_confmtx_nb + confmtx_nb;

    cum_predict_nb = [cum_predict_nb; predict_nb];
    
    %% DT
    tree = ClassificationTree.fit(train_inst, train_label, 'MinLeaf', 2); % 'AlgorithmForCategorical', 'PCA', % , 'SplitCriterion', 'deviance'
    [predict_dt, score_dt] = predict(tree, test_inst);
    
%     tree = classregtree(train_inst, train_label, 'method', 'classification', 'prune', 'off');
%     predict_dt = eval(tree, test_inst);
%     predict_dt = cell2mat(predict_dt);
%     predict_dt = str2num(predict_dt);
    
    [~, confmtx_dt] = confmat(n_to_use, length(test_label), test_label, unique(label_to_use), predict_dt);
%     [pre3, rec3, F3, ave_F3, acc3] = multiple_f_measure(confmtx_dt)
    cum_confmtx_dt = cum_confmtx_dt + confmtx_dt;
    
    cum_predict_dt = [cum_predict_dt; predict_dt];
    
    %% SVM linear
    [predict_svm, accuracy, dec_values, bestc, bestcv, opt_cmd] = mysvm_linear(train_inst, train_label, test_inst, test_label, -10, 10);
    [~, confmtx_svm] = confmat(n_to_use, length(test_label), test_label, unique(label_to_use), predict_svm)
    cum_confmtx_svm = cum_confmtx_svm + confmtx_svm;

    cum_predict_svm = [cum_predict_svm; predict_svm];
    
    %% SVM RBF
    [predict_svm_rbf, accuracy_rbf, dec_values_rbf, bestc_rbf, bestg_rbf, bestcv_rbf, opt_cmd_rbf] = mysvm(train_inst, train_label, test_inst, test_label, -10, 10, -10, 10);
    [~, confmtx_svm_rbf] = confmat(n_to_use, length(test_label), test_label, unique(label_to_use), predict_svm_rbf)
    cum_confmtx_svm_rbf = cum_confmtx_svm_rbf + confmtx_svm_rbf;
    
    cum_predict_svm_rbf = [cum_predict_svm_rbf; predict_svm_rbf];
    
end

    [pre_knn, rec_knn, F_knn, ave_pre_knn, ave_rec_knn, ave_F_knn, acc_knn] = multiple_f_measure(cum_confmtx_knn);
    [pre_nb, rec_nb, F_nb, ave_pre_nb, ave_rec_nb, ave_F_nb, acc_nb] = multiple_f_measure(cum_confmtx_nb);
    [pre_dt, rec_dt, F_dt, ave_pre_dt, ave_rec_dt, ave_F_dt, acc_dt] = multiple_f_measure(cum_confmtx_dt);
    [pre_svm, rec_svm, F_svm, ave_pre_svm, ave_rec_svm, ave_F_svm, acc_svm] = multiple_f_measure(cum_confmtx_svm);
    [pre_svm_rbf, rec_svm_rbf, F_svm_rbf, ave_pre_svm_rbf, ave_rec_svm_rbf, ave_F_svm_rbf, acc_svm_rbf] = multiple_f_measure(cum_confmtx_svm_rbf);
    
    
    %% sort the test inst
    [~, IX] = sort(test_int_idx, 'ascend');
    
    sort_cum_predict_knn = cum_predict_knn(IX);
    sort_cum_predict_nb = cum_predict_nb(IX);
    sort_cum_predict_dt = cum_predict_dt(IX);
    sort_cum_predict_svm = cum_predict_svm(IX);
    sort_cum_predict_svm_rbf = cum_predict_svm_rbf(IX);
    
    %% record the result
    pre = [pre_knn pre_nb pre_dt pre_svm pre_svm_rbf];
    rec = [rec_knn rec_nb rec_dt rec_svm rec_svm_rbf];
    F = [F_knn F_nb F_dt F_svm F_svm_rbf];
    ave_pre = [ave_pre_knn ave_pre_nb ave_pre_dt ave_pre_svm ave_pre_svm_rbf]
    ave_rec = [ave_rec_knn ave_rec_nb ave_rec_dt ave_rec_svm ave_rec_svm_rbf]
    ave_F = [ave_F_knn ave_F_nb ave_F_dt ave_F_svm ave_F_svm_rbf]
    acc = [acc_knn acc_nb acc_dt acc_svm acc_svm_rbf];
    cum_predict = [sort_cum_predict_knn sort_cum_predict_nb sort_cum_predict_dt sort_cum_predict_svm sort_cum_predict_svm_rbf];
    cum_confmtx(:,:,1) = cum_confmtx_knn;
    cum_confmtx(:,:,2) = cum_confmtx_nb;
    cum_confmtx(:,:,3) = cum_confmtx_dt;
    cum_confmtx(:,:,4) = cum_confmtx_svm;
    cum_confmtx(:,:,5) = cum_confmtx_svm_rbf;
    
    classifier_name = {'KNN', 'NB', 'DT', 'SVM(linear)', 'SVM(RBF)'};
    
    % save([data_file_name '_file_' mode '_result.mat'], 'pre', 'rec', 'F', 'ave_pre', 'ave_rec', 'ave_F', 'acc', 'cum_confmtx', 'cum_predict');
