% match n_max times for each test video with length win_size with each train video

% whether the signal is normalized or not - does not affect the matching score if cosine similarity is used

clear;

time_resol = 0.1;

% for the test fraction
% 300, 600, 1200, 1800, 2400
win_size = 1200;

% num of template files % num of test files is always 20
n_temp = 50;

% the max number of times for matching
n_max = 3;

dirName = './sensor-data-matched-filter/'; % location where data is kept

folderNameSet = {'L20cmA4new', 'L20cmA4'}; %, 'L40cmA4', 'L60cmA4', 'L80cmA4', 'L100cmA4'};

addTemplateFolderName = 'AdditionalTemplate';
addTestFolderName = 'AdditionalTest';

nFolder = length(folderNameSet);

for k1 = 1:1% nFolder % only use one of them for template for simplicity

%% Folder names for storing templates and test files
templateFolderName = folderNameSet{k1}; %'L20cmA0';

    for k2 = 1:nFolder

        if k2~=k1
            testFolderName = folderNameSet{k2}; %'L20cmA4';

            %% Get template file names
            FOriTemp = dir([dirName templateFolderName '/*.txt']);
            FAddTemp = dir([dirName addTemplateFolderName '/*.txt']);
                        
            %  record all the filenames
            TempFileName = [...
                get_filename_from_dir([dirName templateFolderName], FOriTemp);
                get_filename_from_dir([dirName addTemplateFolderName], FAddTemp);
                ];
            
            lenTemp = length(TempFileName);
            
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
            % col3 - matching score
            label_score_mat = zeros(lenTest*n_max, 3);

            %% Match each test file with template files, record results and save them in .mat files
            
            for i = 1:lenTest
                % cur_filename = [dirName testFolderName '/' FTest(i).name];
                cur_filename = TestFileName{i};
                Test = importdata(cur_filename);
                utime = Test(:,1)/1e3;
                lgt = Test(:,2);
                [~, lgtTest] = resample_lgt(utime, lgt, time_resol);
                curLen = length(lgtTest);
                    
                % match for n_max times with length of win_size
                    for kk = 1:n_max
                        cur_row = (i-1)*n_max+kk;
                        % randomly choose a starting point
                        rng(kk);
                        idx = randperm(curLen - win_size);
                        curLgtTest = lgtTest(idx(1)+1:idx(1)+win_size);
                        curLgtTest = curLgtTest/norm(curLgtTest);
                        
                        label_score_mat(cur_row,1) = i;
                        
                        file_idx_record = 0;
                        max_score_record = 0;
                        
                        % match with all the training files
                        for j = 1:lenTemp
                            % read in file's data
                            % cur_filename = [dirName templateFolderName '/' FTemp(j).name];
                            cur_filename = TempFileName{j};
                            Temp = importdata(cur_filename);
                            utime2 = Temp(:,1)/1e3;
                            lgt2 = Temp(:,2);
                            [~, lgtTemp] = resample_lgt(utime2, lgt2, time_resol);
                            lgtTemp = lgtTemp/norm(lgtTemp);

                            cur_max = my_shift_correlation(lgtTemp, curLgtTest);
                            % my_shift_cosine(lgtTemp, curLgtTest);
                            
                            % record the max match
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

            save(['label_score_' templateFolderName '_' testFolderName '_' num2str(win_size) '_' num2str(n_temp) '_corr.mat'], 'label_score_mat');
        end
    end
end
