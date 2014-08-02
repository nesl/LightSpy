clear all;

templateSize = 150; % stores the size of sample we want to match
dirName = 'sensor-data-matched-filter/'; % location where data is kept

% Create matched filter for each data template
F = getFileNames(dirName); % get the names of all the files in the dir
len = length(F);
N = 100; % number of iterations 
matchedFilterArr = zeros(templateSize, length(F)); % stores the matched filters
labelArr = {};
errorMat = zeros(len, N);

% There are three recordings of a single file RecA, RecB, RecC
% RecA is considered to be the database entry for the movie. 
% RecB and RecC are used for selecting the template to match
for numRun = 1:N
    k = 1; p = 1;
    for i = 1:len
        if((~isempty(strfind(F{i}, 'RecB'))) || (~isempty(strfind(F{i}, 'RecC'))))
            dataMat = importdata(strcat(dirName,F{i})); % get data for RecB or RecC
            t2 = getMatchedFilter(dataMat, templateSize); 
            matchedFilterArr(:,k) = t2/norm(t2,2); %normalize template
            % Use the fileName to assign a label to the template
            % The labels are stored in vector Y
            [Y(k), labelArr] = checkLabel(getLabel(F{i}), labelArr); 
            k = k + 1;
        else  % If fileName has RecA then use it for the database
            recordedDataCell{p} = F{i};
            [dummy, labelArr] = checkLabel(getLabel(F{i}), labelArr);
            p = p + 1;
        end
    end
    numSamples = k - 1;
    numRecordings = p - 1;
    
    % accMap = getAccuracyMap(templates, F);
    
    accuracyMat = zeros(numSamples, numRecordings);
    classificationArr = zeros(numSamples,1);
    
    % Perform identification
    for i = 1:numSamples
        maxAcc = -999;
        for j = 1:numRecordings
            dataMat = importdata(strcat(dirName,recordedDataCell{j}));
            accuracyMat(i,j) = getMatchScore(matchedFilterArr(:,i),dataMat(:,2));
            if(maxAcc < accuracyMat(i,j))
                maxAcc = accuracyMat(i,j);
                % classificationArr stores the label assigned to each
                % template
                classificationArr(i) = checkLabel(getLabel(recordedDataCell{j}), labelArr);
            end
        end
    end

% Compute Classification accuracy for this run
    errorMat(Y'-classificationArr ~=0, numRun) = 1;
end

temp = sum(errorMat(1:numSamples, :),2);
classErr = zeros(length(labelArr),1);
for i = 1:numSamples
    classErr(Y(i)) = classErr(Y(i)) + temp(i);
end
% The factor 2 in the denominator is because for each class we use 2*N
% tests. One N for the RecB and another N for RecC.
bar(classErr(1:length(labelArr))*100/(N*2), 'barwidth', 0.5); grid on; xlabel('Class Label','fontsize',16); ylabel('Error percentage','fontsize',16);