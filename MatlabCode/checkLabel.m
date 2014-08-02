function [index, labelArr] = checkLabel(label, labelArr)
index = -1;
i = 1;
while ((i <= length(labelArr)) && (index == -1))
    if(strcmp(label, labelArr{i}))
        index = i;
    end
    i = i + 1;
end
if (index == -1)
    labelArr{end+1} = label;
    index = length(labelArr);
end

end

