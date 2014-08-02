close all
win_spec = 128;
% one point shift
n_overlap = win_spec - 1;
n_fft = 256;

idx_freq_range = 80:129; % 78:129; % 1-3Hz, 3-5Hz

rng(1);
idx = randperm(curLen - win_size);
curLgtTest = lgtTest(idx(1)+1:idx(1)+win_size);
curLgtTest = curLgtTest/norm(curLgtTest);

% compute spectrogram
% one point shift
[S,F,T,P] = spectrogram(curLgtTest,win_spec,n_overlap,n_fft,fs);
% visualize
surf(T,F,10*log10(P),'edgecolor','none'); axis tight;
view(0,90);
% find local max
[xymax,smax,xymin,smin] = extrema2(10*log10(P));
local_max_test = zeros(size(P));
local_max_test(smax) = 1;

cur_max2 = my_shift_spectrogram(local_max_temp{2}(idx_freq_range,:), local_max_test(idx_freq_range,:))

cur_max11 = my_shift_spectrogram(local_max_temp{11}(idx_freq_range,:), local_max_test(idx_freq_range,:))

%% plot
figure;
[I1,J1] = ind2sub(size(P),find(local_max_test == 1));
plot(I1,J1,'rs');


    