clear;
close all

%% define parameters
folder_name = '.\sensor-data-classification\';
date = '20140505';
% also sub folder name
class_name = {'Browsing', 'Coding', 'Gaming', 'Movie'};

n_class = length(class_name);

cur_file_label = 0;
fea_mat = [];
file_label = [];
class_label = [];
file_name = cell(0);
n_file_per_class = zeros(n_class, 1);

time_resol = 0.1; % resample internval; in terms of second
win_size = 600;
offset = 200;
fs = 10;

my_color = {'r-x', 'g-+', 'b-*', 'b-*', 'c-o'};

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
        
        [time_vec_out, lgt_out] = resample_lgt(utime, lgt, time_resol);
        
        cur_n_inst = 1 + floor(length(lgt_out-win_size)/offset);
        
        for k = 1:cur_n_inst
        
            close all;

            my_figure(1.2/3,1.2/6);
            % examining raw data
            cur_data = lgt_out((k-1)*offset+1:(k-1)*offset+win_size);
            plot((1:length(cur_data))/fs, cur_data, my_color{i});
            % xlim([1 1500]);
            xlabel('Time (second)', 'fontsize', 18);
            ylabel('Light intensity (lux)', 'fontsize', 18);
            title(class_name{i}, 'fontsize', 18);
            set(gca, 'fontsize', 18);
    
%     % %% periodogram
%     % [P1,f1] = periodogram(cur_data,[],[],fs,'power');
%     % figure;
%     % plot(f1(2:end),P1(2:end),'k'); ylabel('P1');
%     % xlim([0 0.5])
% 
%     % mean
%     fea_mean = mean(cur_data);
%     % std
%     fea_std = std(cur_data);
%     % range
%     fea_range = max(cur_data) - min(cur_data);
%     
%     % mcr
%     sign_frag_mean = sign(cur_data - repmat(fea_mean,size(cur_data,1), 1));
%     sign_diff_mean = sign_frag_mean(2:end,:) - sign_frag_mean(1:end-1,:);
%     fea_mcr = sum(abs(sign_diff_mean))/2/(length(cur_data)-1);
% 
%     % time to change
%     % find all the change positions
%     change_point = find(sign_diff_mean~=0);
%     % the diff of these change points are the durations before change
%     dur_btw_change = diff(change_point);
%     fea_mean_dur_btw_change = mean(dur_btw_change);
%     
        %% FFT
        frag = cur_data(1:win_size);
        NFFT = 2^nextpow2(length(frag));
        % FFT - symmetric - you need to take out over half of it
        Y1 = fft(frag,NFFT);
        f = fs/2*linspace(0,1,NFFT/2+1);
        L = NFFT/2+1;
        my_figure(1.2/3,1.2/6);
        % Plot single-sided amplitude spectrum.
        % subplot(2,2,i)
        % original
        stem(f(2:end), 2*abs(Y1(2:L)), my_color{i}, 'linewidth', 1.5);
        % normalize by the DC component
        % stem(f, 2*abs(Y1(1:L)/Y1(1)), my_color{i}, 'linewidth', 1.5);
        title(class_name{i}, 'fontsize', 18);
        % title('Single-Sided Amplitude Spectrum of y(t)');
        xlabel('Frequency (Hz)', 'fontsize', 18);
        ylabel('FFT magnitude', 'fontsize', 18);
        xlim([0 fs/2]);
        % ylim([0 2e5]);
        set(gca, 'fontsize', 18);
        end
        
    end
end


