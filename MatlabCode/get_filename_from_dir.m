function filename = get_filename_from_dir(dir_path, list)
% dir_path - the path to the dir

n = length(list);
filename = cell(n,1);

for i = 1:n
    filename{i} = [dir_path '/' list(i).name];
end