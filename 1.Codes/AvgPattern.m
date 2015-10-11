function [pattern] = AvgPattern(lead,Rpeaks)

for i=1:length(Rpeaks)-1
        pattern(i,:) = resample(lead(Rpeaks(i)+1:Rpeaks(i+1)),round(mean(diff(Rpeaks))),Rpeaks(i+1)-Rpeaks(i));
end

if size(pattern,1)>2
    pattern = mean(pattern);
end

