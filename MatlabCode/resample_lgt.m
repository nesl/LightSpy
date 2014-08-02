function [time_vec_out, lgt_out] = resample_lgt(utime, lgt, time_resol)

% utime - unix time
% time_resol = 0.1; % 100 millisecond, % in terms of second

time_start = utime(1);
time_end = utime(end);

% input n_inst
n_inst_in = length(utime);

% output n_inst
% ignore the first and last second
n_inst_out = (ceil(time_end) - ceil(time_start))/time_resol;

% relative time - deduct the start time, divided by the resol and convert to integer index
utime_rel_int = floor((utime - utime(1))/time_resol);

%% output
% output time
utime_out = floor(utime(1)) + (1:n_inst_out).'*time_resol;
% output light dat
lgt_out = zeros(n_inst_out, 1);

%% loop for all the input instances
last_out = 1;
% the first utime_rel_int is 0
for i = 2:n_inst_in
    cur_in = utime_rel_int(i); % idx actually
    if last_out > 0
        lgt_out(last_out:cur_in-1) = lgt(i-1); % the values should be the same before current change
    end
    last_out = cur_in;
end

% %% check correctness
% stairs(utime, lgt, 'b');
% hold on
% stairs(utime_out, lgt_out, 'g');

time_vec_out = unixtime(utime_out);
lgt_out = lgt_out(1:n_inst_out);

