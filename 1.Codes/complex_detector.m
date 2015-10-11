function [RS,ST,TP,PQ,QR] = complex_detector(Pattern)

%Detect R to S

window1=Pattern(1:200);
RS=Pattern(1:find(window1==min(window1)));

%Detect S to T

ST=Pattern(find(RS,1,'last'):120+find(Pattern(120:600)==max(Pattern(120:600))));

% Detect T to P
TP=Pattern(120+find(Pattern(120:600)==max(Pattern(120:600))):650+find(Pattern(650:800)==max(Pattern(650:800))));

% detect P to Q

PQ=Pattern(650+find(Pattern(650:800)==max(Pattern(650:800))):600+find(Pattern(600:find(Pattern,1,'last'))==min(Pattern(600:find(Pattern,1,'last')))));

%detect Q to R

QR=Pattern(600+find(Pattern(600:find(Pattern,1,'last'))==min(Pattern(600:find(Pattern,1,'last')))):find(Pattern,1,'last'));
