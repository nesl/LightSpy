clear;

% read in light data from folders and then attach each entry with a movie label and a category label

%% data format
% first column is time; second column is light; listener, the light values
% are recorded only when different from the previous one

%% define parameters
folder_name = '.\sensor-data-classification\';
date = '20140513';
% also sub folder name
class_name = {'Browsing', 'Coding', 'Gaming', 'Movie'};

win_size = 600;

% folder_name = '.\movie-data-20140506\';
% date = '20140505';
% % also sub folder name
% class_name = {'Action', 'Adventure', 'Animation', 'Comedy', 'Sci-Fi'};

n_class = length(class_name);

cur_file_label = 0;
fea_mat = [];
file_label = [];
class_label = [];
file_name = cell(0);
n_file_per_class = zeros(n_class, 1);

time_resol = 0.1; % resample internval; in terms of second
offset = win_size/2;
fs = 10;
thre_sig_diff = 2e-4;

for i = 1:n_class
    cur_class_label = i;
    cur_dir = [folder_name class_name{i}];
    % list all the files in the folder
    list = dir([cur_dir '\*.txt']);
    % number of files
    n = numel(list);
    n_file_per_class(i) = n;
    for j = 1:n   
        cur_file_label = cur_file_label + 1;
        cur_filename = [cur_dir '\' list(j).name];
        
        A = importdata(cur_filename);
        
        utime = A(:,1)/1e3;
        lgt = A(:,2);
        
        [~, lgt_out] = resample_lgt(utime, lgt, time_resol);
        
        [frag_fea_mat, fea_name, frag_class_label, frag_file_label] = ...
            stream_data_feature_extraction_light(lgt_out, fs, win_size, offset, cur_file_label, cur_class_label, thre_sig_diff);
                
        file_name = [file_name; list(j).name];
        fea_mat = [fea_mat; frag_fea_mat];
        file_label = [file_label; frag_file_label];
        class_label = [class_label; frag_class_label];
    end
end

num_class_name = unique(class_label);

num_file_name = unique(file_label);
n_file= length(num_file_name);

save(['light_ft_' date '_' num2str(win_size) '.mat'], 'fea_mat', 'fea_name', 'class_name', 'num_class_name', 'n_class', 'class_label', ...
     'file_name', 'num_file_name', 'n_file', 'file_label', 'n_file_per_class');

%% save to arff
% class_idx = 1;
% wekaOBJ = matlab2weka('light', [fea_name 'category'], ...
% [fea_mat class_label], class_idx);
% % save to arff
% saveARFF(['light_ft_' date '_' num2str(win_size) '.arff'], wekaOBJ);
