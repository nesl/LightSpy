function max_val = my_shift_spectrogram(spec_temp, spec_test)
% need to be matrix of spectrogram
% row - freq, col - time

n_temp = size(spec_temp,2);
n_test = size(spec_test,2);
score_vec = zeros(n_temp - n_test + 1,1);

for i = 1:n_temp - n_test + 1
    cur_spec_temp = spec_temp(:, i:i+n_test-1);
    score_vec(i) = matching_spectrogram(cur_spec_temp, spec_test);
end

max_val = max(score_vec);

end

function matching_score = matching_spectrogram(cur_spec_temp, spec_test)

        idx_matching = ((cur_spec_temp == spec_test) & (spec_test == 1));
        % number of matching
        n_matching = sum(idx_matching(:));
        % number of total distinct 1s
        n_total = sum(cur_spec_temp(:)) + sum(spec_test(:));
        % essentially Jaccard similarity
        matching_score = n_matching/(n_total - n_matching);
end