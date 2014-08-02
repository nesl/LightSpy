function power = mygoertzel(dataArr, freqIndex, numSamples)
s_prev = 0;
s_prev2 = 0;

coeff = 2*cos((2*pi*freqIndex)/numSamples);
for i = 1:length(dataArr)
    sample = dataArr(i);
    s = sample + coeff*s_prev - s_prev2;
    s_prev2 = s_prev;
    s_prev = s;
end
power = s_prev2*s_prev2 + s_prev*s_prev - coeff*s_prev2*s_prev;
