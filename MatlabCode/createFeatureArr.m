function featureArr = createFeatureArr(dataArr, numSamples, label)

blockNum = 1;
startIndex = 1;
endIndex = numSamples;
[numRows numCols] = size(dataArr);
freqMax = 5;
dataCol = 1;
sumCoeff = 0;

while (endIndex <= numRows)
    tmpArr = dataArr(startIndex:endIndex, dataCol);
    normFactor = sum(tmpArr.^2)/numSamples;
    %normFactor = 1;
    for j = 1:freqMax
        featureArr(blockNum, j) = mygoertzel(tmpArr, j, numSamples)/normFactor;
        sumCoeff = sumCoeff + featureArr(blockNum, j);
    end
    j = j + 1;
    featureArr(blockNum, j) = sumCoeff;
    for i = 1:freqMax
        for k = i+1:freqMax
            j = j + 1;
            featureArr(blockNum, j) = ...
                featureArr(blockNum, i)/featureArr(blockNum, k);
        end
    end
    featureArr(blockNum, j+1) = label;
    blockNum = blockNum + 1;
    startIndex = startIndex + 1;
    endIndex = startIndex + numSamples -1;
end

end