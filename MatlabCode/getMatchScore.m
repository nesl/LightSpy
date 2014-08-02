function [score, pattern] = getMatchScore(template, movie)
    k = 1;
    templateSize = length(template);
    score = -999;
    pattern = [];
    
    while (k+templateSize-1 <= length(movie))
        dataWin = movie(k:k+templateSize-1);
        dataWin = dataWin/norm(dataWin, 2);
        temp = dot(template, dataWin);
        if(score <= temp)
            score = temp;
            pattern = dataWin;
        end
        k = k + 1;
    end
end

