clear;

time_resol = 0.1;
fs = 10;

% for the test fraction
% 300, 600, 1200, 1800, 2400
win_size = 1200;
win_spec = 128;
% one point shift
n_overlap = win_spec - 1;
n_fft = 256;
idx_freq_range = 1:52; 

% num of template files % num of test files is always 20
n_temp = 50;

% the max number of times for matching
n_max = 3;

dirName = './sensor-data-matched-filter/'; % location where data is kept

folderNameSet = {'L20cmA4new', 'L20cmA4', 'L40cmA4', 'L60cmA4', 'L80cmA4', 'L100cmA4'};

addTemplateFolderName = 'AdditionalTemplate';
addTestFolderName = 'AdditionalTest';

nFolder = length(folderNameSet);

for k1 = 1:1% nFolder % only use one of them for template for simplicity

%% Folder names for storing templates and test files
templateFolderName = folderNameSet{k1}; %'L20cmA0';

            %% Get template file names
            FOriTemp = dir([dirName templateFolderName '/*.txt']);
            FAddTemp = dir([dirName addTemplateFolderName '/*.txt']);
                        
            %  record all the filenames
            TempFileName = [...
                get_filename_from_dir([dirName templateFolderName], FOriTemp);
                get_filename_from_dir([dirName addTemplateFolderName], FAddTemp);
                ];
            
            lenTemp = length(TempFileName);
            
            local_max_temp = cell(lenTemp, 1);
            
            % compute the spectrogram for all the templates and store them
            for ii = 1:lenTemp
                cur_filename = TempFileName{ii};
                lgt_out = light_data_import(cur_filename,time_resol);
                % normalization
                lgt_out = lgt_out/norm(lgt_out);
                
                % one point shift
                [S,F,T,P] = spectrogram(lgt_out,win_spec,n_overlap,n_fft,fs);
                % find local max
                [xymax,smax,xymin,smin] = extrema2(10*log10(P));
                local_max = zeros(size(P));
                local_max(smax) = 1;
                % store those local max in a matrix
                local_max_temp{ii} = local_max;
            end
            
    for k2 = 3 %nFolder

        if k2~=k1
            testFolderName = folderNameSet{k2}; %'L20cmA4';

            %% Get test file names
            FOriTest = dir([dirName testFolderName '/*.txt']);
            FAddTest = dir([dirName addTestFolderName '/*.txt']);
            
            % record all the filenames
            TestFileName = [ ...
                get_filename_from_dir([dirName testFolderName], FOriTest);
                get_filename_from_dir([dirName addTestFolderName], FAddTest);                
                ];
            
            lenTest = length(TestFileName);
            
            %% record the matching score
            % rows - number of all the tests
            % col1 - current test file's label
            % col2 - matched file's label
            % col3 - matching score - sum abs diff indicator
            % col4 - matching score - sum abs diff mag
            label_score_mat = zeros(lenTest*n_max, 3);

            %% Match each test file with template files, record results and save them in .mat files
            
            for i = 1:lenTest
                % cur_filename = [dirName testFolderName '/' FTest(i).name];
                cur_filename = TestFileName{i};
%                 Test = importdata(cur_filename);
%                 utime = Test(:,1)/1e3;
%                 lgt = Test(:,2);
%                 [~, lgtTest] = resample_lgt(utime, lgt, time_resol);
                lgtTest = light_data_import(cur_filename,time_resol);
                curLen = length(lgtTest);
                    
                % match for n_max times with length of win_size
                    for kk = 1:n_max
                        cur_row = (i-1)*n_max+kk;
                        % randomly choose a starting point
                        rng(kk);
                        idx = randperm(curLen - win_size);
                        curLgtTest = lgtTest(idx(1)+1:idx(1)+win_size);
                        curLgtTest = curLgtTest/norm(curLgtTest);
                        
                        % compute spectrogram
                        % one point shift
                        [S,F,T,P] = spectrogram(curLgtTest,win_spec,n_overlap,n_fft,fs);
                        % find local max
                        [xymax,smax,xymin,smin] = extrema2(10*log10(P));
                        local_max_test = zeros(size(P));
                        local_max_test(smax) = 1;
                        
                        % record the true label                  
                        label_score_mat(cur_row,1) = i;
                        
                        file_idx_record = 0;
                        max_score_record = 0;
                        
                        % match with all the training files
                        for j = 1:lenTemp
%                             % read in file's data
%                             % cur_filename = [dirName templateFolderName '/' FTemp(j).name];
%                             cur_filename = TempFileName{j};
% %                             Temp = importdata(cur_filename);
% %                             utime2 = Temp(:,1)/1e3;
% %                             lgt2 = Temp(:,2);
% %                             [~, lgtTemp] = resample_lgt(utime2, lgt2, time_resol);
%                             lgtTemp = light_data_import(cur_filename,time_resol);
%                             lgtTemp = lgtTemp/norm(lgtTemp);
                            
                            cur_max = my_shift_spectrogram(local_max_temp{j}(idx_freq_range,:), local_max_test(idx_freq_range,:));
                            
                            % record the min match
                            if cur_max >= max_score_record
                                max_score_record = cur_max;
                                file_idx_record = j;
                            end
                            
                        end
                        
                        % after scan through all the files
                        label_score_mat(cur_row,2) = file_idx_record;
                        label_score_mat(cur_row,3) = max_score_record;

                    end
            end

            save(['label_score_' templateFolderName '_' testFolderName '_' num2str(win_size) '_' num2str(n_temp) '_spectrogram' '.mat'], 'label_score_mat');
        end
    end
end
