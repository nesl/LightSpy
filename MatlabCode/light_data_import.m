function lgt_out = light_data_import(filename,time_resol)

data = importdata(filename);
utime = data(:,1)/1e3;
lgt = data(:,2);
[~, lgt_out] = resample_lgt(utime, lgt, time_resol);
