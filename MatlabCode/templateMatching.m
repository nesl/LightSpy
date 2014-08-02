clear all;

templateSize = 70;
dirName = '../../sensor-data-full/';

% Create matched filter for each data template
F = getFileNames(dirName);
len = length(F);

matchedFilterArr = zeros(templateSize, length(F));
for i = 1:len
    dataMat = importdata(strcat(dirName,F{i}));
    t = getMatchedFilter(dataMat, templateSize);
    matchedFilterArr(:,i) = t/norm(t,2);
end

accuracyArr = zeros(len, 3);

% Compute slide dot product and store the max for each clip
for i = 1:len % for every clip
    mf = matchedFilterArr(:,i);
    accuracyArr(i,1) = i; % actual label
    maxAcc = -999;
    sprintf('Working on clip = %d\n',i)
    for j = 1:len % check against every stored movie
        dataMat = importdata(strcat(dirName,F{j}));     
        k = 1;
        while (k+templateSize-1 <= length(dataMat(:,1)))
            dataWin = dataMat(k:k+templateSize-1,1);
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
save ('accuracyArr.mat', 'accuracyArr');
