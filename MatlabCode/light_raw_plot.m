clear;
close all

time_resol = 0.1;

dirName = './sensor-data-matched-filter/'; % location where data is kept

folderNameSet = {'L20cmA4', 'L40cmA4', 'L60cmA4', 'L80cmA4', 'L100cmA4'};

start = 20;
delta = 600;

range = start+1:start+delta;

% synchronize signals
% shift = [100 10 -20 20 -30];
shift = [0 0 -2 1 -3];

targetFileName = 'Aladdin_WholeNewWorld-data.txt';

my_color = {'r-', 'y--', 'g-', 'c--', 'b-', 'm-', 'k--'};

nFolder = length(folderNameSet);

my_figure(1/1.5,1/5);
hold on

for i = 1:nFolder
   cur_filename = [dirName folderNameSet{i} '/' targetFileName];
   lgt_out = light_data_import(cur_filename,time_resol);
   lgt_out = lgt_out(range + shift(i));
   plot((1:length(lgt_out))*time_resol, lgt_out, my_color{i}, 'linewidth', 1.5);
end

%%
legend('20cm', '40cm', '60cm', '80cm', '100cm', 'orientation', 'horizontal');
xlabel('Time (second)', 'fontsize', 18);
ylabel('Light intensity (lux)', 'fontsize', 18);
xlim([0 delta]*time_resol); ylim([0 12]);
set(gca, 'fontsize', 14);

%% normalized signal
lgt_store = zeros(delta, nFolder);

my_figure(1/1.5,1/5);
hold on
for i = 1:nFolder
   cur_filename = [dirName folderNameSet{i} '/' targetFileName];
   lgt_out = light_data_import(cur_filename,time_resol);
   lgt_out = lgt_out(range + shift(i));
   lgt_out = lgt_out/norm(lgt_out);
   lgt_store(:,i) = lgt_out;
   plot((1:length(lgt_out))*time_resol, lgt_out, my_color{i}, 'linewidth', 1.5);
end

%% correlation
corr_store = zeros(nFolder, nFolder);
for i = 1:nFolder
    for j = i+1:nFolder
        corr_store(i,j) = corr(lgt_store(:,i), lgt_store(:,j));
    end
end

idx_val = (corr_store > 0);

mean_corr = mean(corr_store(idx_val))

%%
legend('20cm', '40cm', '60cm', '80cm', '100cm', 'orientation', 'horizontal');
xlabel('Time (second)', 'fontsize', 18);
ylabel('Norm. light intensity', 'fontsize', 18);
xlim([0 delta]*time_resol); ylim([0 0.12]);
set(gca, 'YTick', 0:0.02:0.12, 'fontsize', 14);

%% compute the similarity in correlation/large changes
score_sim = zeros(nFolder, nFolder);
score_diff = zeros(nFolder, nFolder);

for ii = 1:nFolder
    for jj = ii+1:nFolder
        score_sim(ii,jj) = corr(lgt_store(:,jj), lgt_store(:,ii));
        % score_diff(ii,jj) = my_change_matching(lgt_store(:,jj), lgt_store(:,ii));
    end
end


%% compute the similarity in spectro peaks
P_store = [];
% store the indices of peaks
local_max_store = cell(nFolder, 1);
% store the matrix where the corresponding peak value is 1
local_max_store_mat = [];

for i = 1:nFolder
    figure;
    
    [S,F,T,P] = spectrogram(lgt_store(:,i),128,120,256,10);
    P_store = cat(3, P_store, 10*log10(P));
    
    % whether normalization helps??
    % normalize P
    % norm_P = prob_mat_nlz(P,'col');
    [xymax,smax,xymin,smin] = extrema2(10*log10(P));
    local_max = zeros(size(P));
    local_max(smax) = 1;
    local_max_store_mat = cat(3, local_max_store_mat, local_max);
    local_max_store{i} = smax;
    
    surf(T,F,10*log10(P),'edgecolor','none'); axis tight; 
    view(0,90);
    xlabel('Time (second)', 'fontsize', 18);
    ylabel('Frequency (Hz)', 'fontsize', 18);
    colorbar
    set(gca, 'fontsize', 18);
end

%% visualize 
my_color = {'rx', 'go', 'bv', 'm+', 'cs'};
figure;
hold on
for i = [1 5]% nFolder
    [I,J] = ind2sub(size(P),local_max_store{i});
    plot(I,J,my_color{i});
end
hold off

%% calculate the score of matching two matrices
matching_score = zeros(nFolder, nFolder);
[s1,s2] = size(local_max_store_mat(:,:,1));

for i = 1:nFolder
    for j = i+1:nFolder
        % you should not consider 0s as matching; but only 1s
        idx_matching = (local_max_store_mat(:,:,i) == local_max_store_mat(:,:,j)) & (local_max_store_mat(:,:,i) == 1);
        % number of matching
        n_matching = sum(idx_matching(:));
        % number of total distinct 1s
        n_total = sum(sum(local_max_store_mat(:,:,i))) + sum(sum(local_max_store_mat(:,:,j)));
        % essentially Jaccard similarity
        matching_score(i,j) = n_matching/(n_total - n_matching);
    end
end

score_sim

matching_score

