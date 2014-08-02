function matchedFilter = getMatchedFilter(dataMat, clipSize)
% creates a matched filter for a clip of size clipSize
startPos = 1;
endPos = 1;
len = length(dataMat(:,2));
% sprintf('clipsize = %d\n',clipSize)
while((endPos > len) || ((endPos-startPos) ~= clipSize))
    temp = randperm(len);
    startPos = temp(1);
    %startPos = 30;
    endPos = startPos + clipSize;
    % sprintf('startPos = %d::endPos = %d\n',startPos, endPos)
end

template = dataMat(startPos:endPos-1, 2);
% matchedFilter = flipud(template);

% Simply return the captured clip
matchedFilter = template;

% sprintf('Size of matchedFilter = %d\n',length(matchedFilter))
end
