function score_diff = my_change_matching(frag_temp, frag_test)
% the first is the template frag
% the second is the test frag
% the two frag should have the same length

n_test = length(frag_test);

% first normalization
frag_temp = frag_temp/norm(frag_temp);
frag_test = frag_test/norm(frag_test);


figure;
hold on
plot(frag_test, 'r', 'linewidth', 1.5);
plot(frag_temp, 'b', 'linewidth', 1.5);
hold off

% calculate sig diff
frag_diff_temp = frag_temp(2:end,:) - frag_temp(1:end-1,:);
frag_diff_test = frag_test(2:end,:) - frag_test(1:end-1,:);

% set 1/3 of the range as the significant change - the test is the standard
change_thre = 1/3*max(abs(frag_diff_test));

figure;
hold on
plot(frag_diff_test, 'r', 'linewidth', 1.5);
plot(frag_diff_temp, 'b', 'linewidth', 1.5);
plot([1 length(frag_diff_test)], [change_thre change_thre], 'k');
plot([1 length(frag_diff_test)], [-change_thre -change_thre], 'k');
hold off

% find change point
idx_up_temp = (frag_diff_temp >= change_thre);
idx_down_temp = (frag_diff_temp <= -change_thre);
idx_change_temp = (idx_up_temp - idx_down_temp);

%% match the idx_change between two frags
% at least the temp has some changes
if sum(abs(idx_change_temp))~=0
    
    idx_up_test = (frag_diff_test >= change_thre);
    idx_down_test = (frag_diff_test <= -change_thre);
    idx_change_test = (idx_up_test - idx_down_test);
    
    %% binned change
    bin_width = 10;
    n_bin = floor((n_test-1)/bin_width);
    bin_change_temp = zeros(n_bin, 1);
    bin_change_test = zeros(n_bin, 1);

    for i = 1:n_bin
        cur_idx = (i-1)*bin_width + 1: i*bin_width;
        cur_change_temp = idx_change_temp(cur_idx);
        cur_change_test = idx_change_test(cur_idx);

        % if cur_change_temp contains -1
        if ismember(-1,cur_change_temp)
            bin_change_temp(i) = -1;
        % or it contains 1
        elseif ismember(1, cur_change_temp)
            bin_change_temp(i) = 1;
        end

        % if cur_change_test contains -1
        if ismember(-1,cur_change_test)
            bin_change_test(i) = -1;
        % or it contains 1
        elseif ismember(1, cur_change_test)
            bin_change_test(i) = 1;
        end

    end

    idx_matching = (((bin_change_temp == bin_change_test) & (bin_change_test == 1)) | ((bin_change_temp == bin_change_test) & (bin_change_test == -1)));
    score_matching = sum(idx_matching)/(length(bin_change_test) + sum(abs(bin_change_test)));
    score_diff = 1 - score_matching;

%     score_diff = sum(abs(bin_change_temp - bin_change_test))/(length(bin_change_test) + sum(abs(bin_change_test))); % only consider the point of change
%     score_diff_mag = sum(abs(idx_change_temp.*frag_diff_temp - idx_change_test.*frag_diff_test)); % consider the magnitude of change as well

else
    score_diff = inf;
end

% %% plot out the two signals
figure;
hold on
stairs(bin_change_temp, 'r');
stairs(bin_change_test, 'b', 'linewidth', 1.5);
hold off

disp('Here');

% figure;
% hold on
% plot(idx_change_temp.*frag_diff_temp, 'r');
% plot(idx_change_test.*frag_diff_test, 'b');
% hold off
