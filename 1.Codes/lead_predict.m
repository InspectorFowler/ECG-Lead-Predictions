function [] = lead_predict(leadPred,leadbase,leadPredcheck,sample)

% Filter all the leads by passing them through a bandpass filter

leadPred=fftfilter150(leadPred,0.5,40);
leadbase=fftfilter150(leadbase,0.5,40);
leadPredcheck=fftfilter150(leadPredcheck,0.5,40);

% Find the Rpeaks for all the leads
% NOTE : We are calculating the Rpeaks for check lead as well for proper
% plotting

RpeakPred=Rpeak_detector(leadPred,sample);
Rpeakbase=Rpeak_detector(leadbase,sample);
RpeakPredcheck=Rpeak_detector(leadPredcheck,sample);

% NOTE : We would have the same number of rpeaks in both the lead

leadPredchecksub=[];
resampleleadPred=[];
leadbasesub=[];
for i=1:(length(RpeakPred)-1)
    
        % Find all the R-R curves in leads I,II &Icheck and store them in a matrix
        
        PatternPred=(leadPred(RpeakPred(i)+1:RpeakPred(i+1)));
        Patternbase=(leadbase(Rpeakbase(i)+1:Rpeakbase(i+1)));
        PatternPredcheck=(leadPredcheck(RpeakPredcheck(i)+1:RpeakPredcheck(i+1)));
        
        % Find the QRS complexes for leads I & II and resampling lead I 
        
        [RSI,STI,TPI,PQI,QRI]=complex_detector(PatternPred);
        [RSII,STII,TPII,PQII,QRII]=complex_detector(Patternbase);
        RSresampled=resample(RSI,length(RSII),length(RSI));
        STresampled=resample(STI,length(STII),length(STI));
        TPresampled=resample(TPI,length(TPII),length(TPI));
        PQresampled=resample(PQI,length(PQII),length(PQI));
        QRresampled=resample(QRI,length(QRII),length(QRI));
        resampled=horzcat(RSresampled,STresampled,TPresampled,PQresampled,QRresampled);
        resampled=resample(resampled,length(Patternbase),length(resampled));
        resampleleadPred=horzcat(resampleleadPred,resampled);
        leadPredchecksub=horzcat(leadPredchecksub,PatternPredcheck);
        leadbasesub=horzcat(leadbasesub,Patternbase);
end

% Plotting the two leads
plot(leadPredchecksub(1,1:3000))
grid on
grid minor
hold on
plot(resampleleadPred(1,1:3000))  
