function map = getAccuracyMap(templates, F)
    len = length(F);
    numTemplate = length(templates);
    
    map = zeros(numTemplate, len);
    for i = 1:numTemplate
        currLabel = templates{i};
        for j = 1:len
            indexArr = findstr('-', F{j});
            temp = F{j};
            label = temp(1:indexArr(1)-1);
            if(strcmp(label, currLabel))
                map(i, j) = 1;
            end
        end
    end
end

