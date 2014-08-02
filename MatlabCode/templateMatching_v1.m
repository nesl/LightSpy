clear all;

templateSize = 70;
dirName = '.\sensor-data-full\';
noiseRatio = 0.1; % add a Gaussian noise with mean 0 and std of noiseRatio*range of dataWin

% Create matched filter for each data template
% F = getFileNames(dirName);
F = dir([dirName '\*.txt']);
len = length(F);

load matchedFilterArr.mat

% matchedFilterArr = zeros(templateSize, length(F));
% for i = 1:len
%     dataMat = importdata(strcat(dirName,F(i).name)); % F{i}
%     t = getMatchedFilter(dataMat, templateSize);
%     matchedFilterArr(:,i) = t/norm(t,2);
% end

% save ('matchedFilterArr.mat', 'matchedFilterArr');

accuracyArr = zeros(len, 3);

% Compute slide dot product and store the max for each clip
for i = 1:len % for every clip
    mf = matchedFilterArr(:,i);
    accuracyArr(i,1) = i; % actual label
    maxAcc = -999;
    sprintf('Working on clip = %d\n',i)
    for j = 1:len % check against every stored movie
        dataMat = importdata(strcat(dirName,F(j).name)); % F{j}
        k = 1;
        while (k+templateSize-1 <= length(dataMat(:,1)))
            dataWin = dataMat(k:k+templateSize-1,1);
            rangeDataWin = range(dataWin);
            dataWin = dataWin + noiseRatio*rangeDataWin*randn(size(dataWin,1),1); % add noise
            dataWin = dataWin/norm(dataWin, 2);
            temp = dot(mf, dataWin);
            if(maxAcc <= temp)
                maxAcc = temp;
                accuracyArr(i,2) = j;
                accuracyArr(i,3) = maxAcc;
            end
            k = k + 1;
        end
        clear dataMat;
    end
end

accuracyArr

% save ('accuracyArr.mat', 'accuracyArr');

classDiff = (accuracyArr(:,1) - accuracyArr(:,2));
acc = sum(classDiff == 0)/length(classDiff)

