clear;

folder_name = '.\SortedMovieData\';
sub_folder_name = 'Action\';
file_name = 'AlienResurrection_ToTheWallFeatureArray.mat';

load([folder_name sub_folder_name file_name])

% correlation
[n_row, n_col] = size(featureArray);
corr_mat = ones(n_col, n_col);

for i=1:n_col
    for j = i+1:n_col
    [R, P] = corrcoef(featureArray(:,i), featureArray(:,j));
    corr_mat(i,j) = R(1,2);
    corr_mat(j,i) = R(1,2);
    end
end

imagesc(corr_mat);
colorbar

hold on
for i = 1:n_col
    for j = 1:n_col
        if i~=j
        tt = num2str(corr_mat(i,j));
        text(i-0.25,j,tt(1:4),'FontWeight','bold');
        end
    end
end

% visualize the features
my_color = {'r-x', 'b-*', 'g-o', 'c-d', 'm-v', 'k-+', 'y->'};
figure;
hold on
for i = 1:7
    plot(1:n_row, featureArray(:,i), my_color{i});
end
hold off
legend('1', '2', '3', '4', '5', '6', '7');
ylim([0 100])
