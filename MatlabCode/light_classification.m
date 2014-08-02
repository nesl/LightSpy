clear;

% load movie_feature.mat

load light_feature_20140421.mat

n_fold = 10;

% %% filtering
% energy = sum(feature_array.^2,2);
% thre = 100;
% idx_retain = (energy > thre);
% 
% % no DC component
% feature_array = feature_array(idx_retain,2:end);
% class_label = class_label(idx_retain);
% movie_label = movie_label(idx_retain);

%% normalization
% feature_array = feature_array./repmat(energy, 1, 12);

n_inst = length(label); % movie_label

%% CV partition
seed = 1;
rng(seed);
cvo = cvpartition(n_inst,'k',n_fold);

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
label_to_use = label; % class_label;
n_to_use = length(unique(label_to_use)); % n_class
feature_mat = fea_mat; % feature_array
cum_confmtx_dt = zeros(n_to_use, n_to_use);
cum_confmtx_nb = zeros(n_to_use, n_to_use);
cum_confmtx_knn = zeros(n_to_use, n_to_use);
cum_confmtx_svm = zeros(n_to_use, n_to_use);

for iter = 1:n_fold
    train_idx = cvo.training(iter);
    test_idx = cvo.test(iter);
    
    % training data
    train_inst = feature_mat(train_idx,:);
    train_label = label_to_use(train_idx);

    % testing data
    test_inst = feature_mat(test_idx,:);
    test_label = label_to_use(test_idx);
    
    %% KNN
    predict_knn = knnclassify(test_inst, train_inst, train_label, 3, 'cosine'); % if not normalized, use 'cosine' similarity; otherwise, use Euclidean
    % smooth the output
    [~, confmtx_knn] = confmat(n_to_use, length(test_label), test_label, unique(label_to_use), predict_knn);
    [pre1, rec1, F1, ave_F1, acc1] = multiple_f_measure(confmtx_knn)
    cum_confmtx_knn = cum_confmtx_knn + confmtx_knn;

%     %% NB
%     nb = NaiveBayes.fit(train_inst, train_label, 'distribution', 'kernel', 'prior', 'uniform');
%     [post_nb,predict_nb] = posterior(nb,test_inst,'HandleMissing','on');
% 
%     idx_nan = isnan(predict_nb);
%     predict_nb(idx_nan) = 0;
%     post_nb(idx_nan,:) = 0;
% 
%     [~, confmtx_nb] = confmat(n_to_use, length(test_label), test_label, unique(label_to_use), predict_nb);
%     [pre3, rec3, F3, ave_F3, acc3] = multiple_f_measure(confmtx_nb)

    %% DT
    tree = ClassificationTree.fit(train_inst, train_label, 'MinLeaf', 2); % 'AlgorithmForCategorical', 'PCA', % , 'SplitCriterion', 'deviance'
    [predict_dt, score_dt] = predict(tree, test_inst);
    
%     tree = classregtree(train_inst, train_label, 'method', 'classification', 'prune', 'off');
%     predict_dt = eval(tree, test_inst);
%     predict_dt = cell2mat(predict_dt);
%     predict_dt = str2num(predict_dt);
    
    [~, confmtx_dt] = confmat(n_to_use, length(test_label), test_label, unique(label_to_use), predict_dt);
    [pre2, rec2, F2, ave_F2, acc2] = multiple_f_measure(confmtx_dt)
    cum_confmtx_dt = cum_confmtx_dt + confmtx_dt;
    
    %% SVM
    [predict_svm, accuracy, dec_values, bestc, bestg, bestcv, opt_cmd] = mysvm(train_inst, train_label, test_inst, test_label, -10, 10, -8, 8);
    [~, confmtx_svm] = confmat(n_to_use, length(test_label), test_label, unique(label_to_use), predict_svm)
    cum_confmtx_svm = cum_confmtx_svm + confmtx_svm;

end

%     [pre_knn, rec_knn, F_knn, ave_F_knn, acc_knn] = multiple_f_measure(cum_confmtx_knn)
    [pre_nb, rec_nb, F_nb, ave_F_nb, acc_nb] = multiple_f_measure(cum_confmtx_knn)
    [pre_dt, rec_dt, F_dt, ave_F_dt, acc_dt] = multiple_f_measure(cum_confmtx_dt)
    [pre_svm, rec_svm, F_svm, ave_F_svm, acc_svm] = multiple_f_measure(cum_confmtx_svm)
    