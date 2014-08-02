function label = getLabel(fileName)
    indexArr = strfind(fileName, '-');
    label = fileName(1:indexArr(1)-1);
end

