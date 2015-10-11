function [Rpeaks,HeartRate,R_series,RR] = rpeak1(ecg,fs)

    N = length(ecg);
    m = 1;
for j = 1:fs:N-fs
    PeakMax(m) = max(ecg(j:j+fs));
    m = m+1;
end
    [hn,xout] = hist(PeakMax,16);
    [C,I] = max(hn);
    PeakM = xout(I);
    R_series =0;
    h= 1;
    k = 1;
    t=1;
    Rpeaks = 0;
    HeartRate= 0;
% fprintf('----------------------- Start of QRS detector  ---------------------\n');
%a(1:N)= 0;              % R amplitide
%b(1:N)= 0;              % R-R interval 
for i = 1:1:N
    if i == 1
        HeartRate(i)=0;
    else    
        HeartRate(i)= HeartRate(i-1);
    end    
    if (ecg(i)>=0.5*PeakM)
        if (i-1)<0.4*fs || (i+1)> N-0.4*fs          %consider current signal position belong to QRS
            continue;
        end
        if ecg(i) == max(ecg(i-0.4*fs:i+0.4*fs))
            Rpeaks(k) = i;
                         
                R_series(k)= ecg(i);                           %get the R amplitude 
         
            k = k+1;    
        end    
    end
    
end
    RR = diff(Rpeaks)/fs;


% fprintf('----------------------- End of QRS detector  ---------------------\n');