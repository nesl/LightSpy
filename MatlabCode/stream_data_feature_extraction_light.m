function [fea_mat, fea_name, class_label, file_label] = stream_data_feature_extraction_light(data, fs, win_size, offset, file_idx, file_class, thre_sig_diff)
% data is a column vector (from a file) with various length
% file_idx - start from 1, all the data extracted from the same file have the same file_idx
% file_class - the data file belongs to which class

fea_mat = [];

n_inst = 1 + floor((length(data)-win_size)/offset); % 1 is for the win_size
    
for j = 1:n_inst
    
    close all
    
    frag = data((j-1)*offset+1:(j-1)*offset+win_size);
    
    % normalize
    frag = frag/norm(frag);

    % mean
    fea_mean = mean(frag);
    % std
    fea_std = std(frag);
    % range
    fea_range = max(frag) - min(frag);    
    
    % absolute difference between consecutive values
    frag_diff = frag(2:end,:) - frag(1:end-1,:); % need to take the absoluate value!!! - otherwise, positive and negative changes cancel out
    fea_mean_deriv = mean(abs(frag_diff));
            
%     %% 
%     my_figure(1/2.5, 1/4)
%     plot((1:length(frag))/10,frag,'b', 'linewidth', 1.5);
%     hold on
%     % plot((1:length(frag))/10,repmat(fea_mean,1,length(frag)),'c', 'linewidth', 1.5);
%     xlabel('Time (second)', 'fontsize', 18);
%     ylabel('Norm. light intensity', 'fontsize', 18);
%     set(gca, 'YGrid', 'on', 'fontsize', 14);
    
    %%
    % mcr
    % difference of current frag values and frag mean
    diff_frag_mean = frag - repmat(fea_mean,size(frag,1), 1);
    abs_diff_frag_mean = abs(diff_frag_mean);
    sig_abs_diff_idx = (abs_diff_frag_mean > thre_sig_diff);
    
    sign_frag_mean = sign(diff_frag_mean);
    sign_diff_mean = sign_frag_mean(2:end,:) - sign_frag_mean(1:end-1,:);
    % only consider points which cross the mean with significant magnitude
    sign_diff_mean_prime = sig_abs_diff_idx(2:end).*sign_diff_mean;
    fea_mcr = sum(abs(sign_diff_mean_prime))/2/(length(frag));
    
    if isempty(fea_mcr) || isnan(fea_mcr)
        fea_mcr = 0;
    end

%     % time to change
%     % find all the change positions
%     
%     change_point = find(sign_diff_mean_prime~=0);
%     % the diff of these change points are the durations before change
%     dur_btw_change = diff(change_point);
%     % fea_mean_dur_btw_change = mean(dur_btw_change);
%     
%     fea_max_dur_btw_change = max(dur_btw_change);
%     
%     % only one change point detected
%     if isempty(fea_max_dur_btw_change) && ~isempty(change_point)
%         fea_max_dur_btw_change = max([win_size-change_point change_point]);
%     elseif isempty(change_point)
%         fea_max_dur_btw_change = win_size/2;
%     end
        
    % skewness % correct for bias
    fea_skew = skewness(frag,0);
    
%     % kurtosis
%     fea_kurt = kurtosis(frag,0);
    
    %% FFT
    NFFT = 2^nextpow2(length(frag));
    % FFT - symmetric - you need to take out over half of it
    Y1 = fft(frag,NFFT);
    f = fs/2*linspace(0,1,NFFT/2+1);
    L = NFFT/2+1;
   
    % fea_fft = 2*abs(Y1(2:L));
    
    % entropy
    fea_ent = my_continuous_entropy(abs(Y1(2:L)));
    
    % put fft into freq bands
    % sub-band (0,1/8], (1/8,1/4], (1/4,1/2]
    ind_freq1 = find(f<=fs/8, 1, 'last');
%     ind_freq2 = find(f<=fs*2/8, 1, 'last');
% 	ind_freq3 = find(f<=fs*3/8, 1, 'last');
    % normalized energy
%     fea_fft_band_energy = [sum(abs(Y1(2:ind_freq1)).^2) sum(abs(Y1(ind_freq1+1:ind_freq2)).^2) ...
%         sum(abs(Y1(ind_freq2+1:ind_freq3)).^2) sum(abs(Y1(ind_freq3+1:L)).^2)]/sum(abs(Y1(2:L)).^2); % *2/NFFT

%    fea_fft_band_energy = [sum(abs(Y1(2:ind_freq1)).^2) sum(abs(Y1(ind_freq1+1:L)).^2)]/sum(abs(Y1(2:L)).^2); % *2/NFFT

    fea_fft_band_energy = sum(abs(Y1(ind_freq1+1:L)).^2)/sum(abs(Y1(2:L)).^2); % *2/NFFT
%     %% more features % useless
    % spectral centroid
    fft_square = abs(Y1(2:L)).^2;
    fea_sp_cen = (2:L)*fft_square/sum(fft_square);
%     % skewness in fft
%     fea_skew_fft = skewness(abs(Y1(2:L)),0);
    
    cur_fea = [fea_range fea_std fea_mean_deriv fea_mcr fea_skew fea_ent fea_fft_band_energy fea_sp_cen];

    fea_mat = [fea_mat; cur_fea];

end

file_label = file_idx*ones(n_inst, 1);
class_label = file_class*ones(n_inst, 1);
    
% replace nan and inf by 0
%% check NaN and Inf
fea_mat(isnan(fea_mat))=0;
fea_mat(isinf(fea_mat))=0;

fea_name = {'Range', 'Standard deviation', 'Mean absolute derivative', 'Mean-crossing rate', 'Skewness', ...
    'Entropy', 'High-frequency energy ratio', 'Spectral centroid'}; % 'Low-frequency energy ratio'

