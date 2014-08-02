function max_val = my_shift_cosine(vec_temp, vec_test)
% need to be column vectors

n_temp = length(vec_temp);
n_test = length(vec_test);
score_vec = zeros(n_temp,1);

norm_test = norm(vec_test);

for i = 1:n_temp - n_test + 1
    cur_temp = vec_temp(i:i+n_test-1);
    score_vec(i) = vec_test.'*cur_temp/norm(cur_temp);
end

max_val = max(score_vec/norm_test);