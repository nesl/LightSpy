% match each full test video with each train video
clear;

time_resol = 0.1;

dirName = './sensor-data-matched-filter/'; % location where data is kept

folderNameSet = {'L20cmA0', 'L20cmA4', 'L40cmA4', 'L60cmA4', 'L80cmA4', 'L100cmA4'};

nFolder = length(folderNameSet);

for k1 = 1:nFolder

%% Folder names for storing templates and test files
templateFolderName = folderNameSet{k1}; %'L20cmA0';

    for k2 = 1:nFolder

        if k2~=k1
            testFolderName = folderNameSet{k2}; %'L20cmA4';

            %% Get template file names
            FTemp = dir([dirName templateFolderName '/*.txt']);
            lenTemp = length(FTemp);

            %% Get test file names
            FTest = dir([dirName testFolderName '/*.txt']);
            lenTest = length(FTest);

            % record the matching score
            score_mat = zeros(lenTest, lenTemp);

            %% Match each test file with template files, record results and save them in .mat files
            for i = 1:lenTest

                    cur_filename = [dirName testFolderName '/' FTest(i).name];
                    Test = importdata(cur_filename);
                    utime = Test(:,1)/1e3;
                    lgt = Test(:,2);
                    [~, lgtTest] = resample_lgt(utime, lgt, time_resol);
                        
                        for j = 1:lenTemp
                                % read in file's 
                                cur_filename = [dirName templateFolderName '/' FTemp(j).name];
                                Temp = importdata(cur_filename);
                                utime2 = Temp(:,1)/1e3;
                                lgt2 = Temp(:,2);
                                [~, lgtTemp] = resample_lgt(utime2, lgt2, time_resol);

%                                 % cross correlation
%                                 m = std(lgtTest)*std(lgtTemp);
%                                 c = xcov(lgtTest, lgtTemp); % cov - unnormalized - need to divided by the signal length
%                                 score_mat(i,j) = max(c)/length(lgtTest)/m; % coeff - divided by std1*std2

                                score_mat(i,j) = my_shift_cosine(lgtTemp, lgtTest);
                        end
            end

            save([templateFolderName '_' testFolderName '.mat'], 'score_mat');
        end
    end
end
