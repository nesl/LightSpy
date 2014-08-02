clear;

folder_name = '.\sensor-data-matched-filter\';
date = '20140505';
sub_folder_name1 = 'L20cmA0';
sub_folder_name2 = 'L20cmA4';
time_resol = 0.1;

dir1 = [folder_name sub_folder_name1];
    % list all the files in the folder
    list = dir([dir1 '\*.txt']);
    % number of files
    n = numel(list);
    
    data_cell1 = cell(n,1);   
    for j = 1:n   
        cur_filename = [dir1 '\' list(j).name];
        
        A = importdata(cur_filename);
        
        utime = A(:,1)/1e3;
        lgt = A(:,2);
        
        [~, lgt_out] = resample_lgt(utime, lgt, time_resol);
                
        data_cell1{j} = lgt_out;
    end
    
dir2 = [folder_name sub_folder_name2];
    % list all the files in the folder
    list = dir([dir2 '\*.txt']);
    
    data_cell2 = cell(n,1);   
    for j = 1:n   
        cur_filename = [dir2 '\' list(j).name];
        
        A = importdata(cur_filename);
        
        utime = A(:,1)/1e3;
        lgt = A(:,2);
        
        [~, lgt_out] = resample_lgt(utime, lgt, time_resol);
                
        data_cell2{j} = lgt_out;
    end
    
    %%
    corr_mat = zeros(n,n);
    for i = 1:n
        for j = 1:n
            n1 = length(data_cell1{i});
            n2 = length(data_cell2{j});
            m = min(n1,n2);
        [R, P] = corrcoef(data_cell1{i}(1:m), data_cell2{j}(1:m));
        corr_mat(i,j) = R(1,2);
        end
    end
    
    imagesc(corr_mat)
    colorbar
    % set(gca,'YDir','normal')
    
    hold on
    for i = 1:n
        for j = 1:n
            text(j-0.3,i,num2str(corr_mat(i,j)), 'fontsize',10);
        end
    end
    
    
    