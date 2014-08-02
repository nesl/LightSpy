function [pre, rec, F, ave_F, acc] = multiple_f_measure(conf_mat)

n_class = size(conf_mat, 1);
% % calculate precision, recall, and F-measure
pre = zeros(n_class, 1);
rec = zeros(n_class, 1);
F = zeros(n_class, 1);
w = zeros(n_class, 1);

all = sum(conf_mat(:));

for i = 1:n_class
    pre(i) = conf_mat(i,i)/sum(conf_mat(:,i));
    rec(i) = conf_mat(i,i)/sum(conf_mat(i,:));
    F(i) = 2*pre(i)*rec(i)/(pre(i) + rec(i));
    w(i) = sum(conf_mat(i,:))/all;
end

nan_ind = isnan(F);
F(nan_ind) = zeros(sum(nan_ind), 1);
ave_F = w.'*F;

acc = sum(diag(conf_mat))/all;