clear;

file_name = 'movie_ft_20140505_600'; % light_ft_20140421 movie_ft_20140427

load([file_name '.mat']);

%% k-means
% k = 2;
% 
% [IDX,C,sumd] = kmeans(fea_mat,k,'distance','cosine');
% 
% [silh,h] = silhouette(fea_mat,IDX,'cosine');
% set(get(gca,'Children'),'FaceColor',[.8 .8 1])
% xlabel('Silhouette Value')
% ylabel('Cluster')
% 
% mean(silh)

%% hierarchical
% normalization
fea_mat = datascale(fea_mat);
n_dim = size(fea_mat, 2);
Y = pdist(fea_mat, 'cosine');
Z = linkage(Y, 'average'); % 'average', 'complete'
dendrogram(Z);
ylim([0 0.1])
c = cophenet(Z,Y)

%%
cutoff = 0.05;

T = cluster(Z,'cutoff',cutoff,'criterion','distance');

n_cluster = length(unique(T));

% calculate cluster centers
cluster_center = zeros(n_cluster, n_dim);
n_ele_per_cluster = zeros(n_cluster, 1);
for i = 1:n_cluster
    cur_idx = (T == i);
    n_ele_per_cluster(i) = sum(cur_idx);
    cluster_center(i,:) = mean(fea_mat(cur_idx,:), 1);
end

%% scatter plot

% the index of the three features to plot
idx1 = 1;
idx2 = 2;
idx3 = 3;

figure;
scatter3(fea_mat(:,idx1),fea_mat(:,idx2),fea_mat(:,idx3),30,T, 'fill');
xlabel('x');
ylabel('y');
zlabel('z');

hold on
plot3(cluster_center(:,idx1), cluster_center(:,idx2), cluster_center(:,idx3), 'kd', 'linewidth', 2, 'markersize', 18);
