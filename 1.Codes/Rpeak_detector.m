function [Rpeaks] = Rpeak_detector(lead,sample)

% Currently using the rpeak1 function followed by manual calculation for
% missing peaks

[Rpeaks,HeartRate,R_series,RR] = rpeak1(lead,sample);
    Rpeaktemp=[];
    for i =1:1:Rpeaks(1)-10  %detect the first R peak undetected by the rpeak1 function
        if lead(i)>0.6*lead(Rpeaks(1))
            Rpeaktemp=[Rpeaktemp,i];
        end
    end
    [C,Idx] = max(lead(Rpeaktemp));
    Rpeaksf = Rpeaktemp(Idx);
    Rpeaktemp=[];
    for i =length(lead):-1:Rpeaks(end)+10  %detect the last R peak undetected by the rpeak1 function
        if lead(i)>0.8*lead(Rpeaks(end))
            Rpeaktemp=[Rpeaktemp,i];
        end  
    end
    [C,Idx] = max(lead(Rpeaktemp));
    Rpeaksl = Rpeaktemp(Idx);
    Rpeaks = [Rpeaksf Rpeaks Rpeaksl];%All adjusted R peaks