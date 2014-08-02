clear;
close all

time_resol = 0.1;

% movie
dirName = './sensor-data-matched-filter/'; % location where data is kept
folderNameSet = 'L20cmA4';
targetFileName = 'Aladdin_WholeNewWorld-data.txt';

% % browsing
% dirName = './sensor-data-classification/';
% folderNameSet = 'Browsing';
% targetFileName = 'browsing_20140503-data.txt';

% coding
% dirName = './sensor-data-classification/';
% folderNameSet = 'Coding';
% targetFileName = 'coding_20140504-data.txt';

% % gaming
% dirName = './sensor-data-classification/';
% folderNameSet = 'Gaming';
% targetFileName = 'gaming_RaymanLegends-data.txt';


my_color = {'r-', 'g-', 'c-', 'b-', 'm-', 'k-'};

nFolder = length(folderNameSet);

%%
my_figure(1/2.5,1/4);
cur_filename = [dirName folderNameSet '/' targetFileName];
lgt_out = light_data_import(cur_filename,time_resol);
lgt_out = lgt_out(300:1500); % 1200:2400 - browsing, 300:1500 - movie
lgt_out = lgt_out/norm(lgt_out);
plot((1:length(lgt_out))*time_resol, lgt_out, my_color{6}, 'linewidth', 1.5);
xlabel('Time (second)', 'fontsize', 18);
ylabel('Norm. light intensity', 'fontsize', 18);
title('Media','fontsize', 18)
xlim([0 120]);
% ylim([0.02 0.035]);
set(gca, 'fontsize', 18, 'XTick', 0:20:120);

%%
my_figure(1/2.22,1/4);
% spectrogram(lgt_out,64);

[S,F,T,P] = spectrogram(lgt_out,64,60,256,10);
% normalize P
% norm_P = prob_mat_nlz(P,'col');
surf(T,F,10*log10(P),'edgecolor','none'); axis tight; 
view(0,90);
xlabel('Time (second)', 'fontsize', 18);
ylabel('Frequency (Hz)', 'fontsize', 18);
caxis([-120, -20])
colorbar
set(gca, 'fontsize', 18);
