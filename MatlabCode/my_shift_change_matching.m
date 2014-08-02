function min_val = my_shift_change_matching(vec_temp, vec_test)
% need to be column vectors

n_temp = length(vec_temp);
n_test = length(vec_test);
score_vec_diff = zeros(n_temp - n_test + 1,1);

for i = 1:n_temp - n_test + 1
    cur_temp = vec_temp(i:i+n_test-1);
    score_vec_diff(i) = my_change_matching(cur_temp, vec_test);
end

min_val = min(score_vec_diff);

score_vec_diff

disp('here');
