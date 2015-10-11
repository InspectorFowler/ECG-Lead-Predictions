function filtersignal = fftfilter(ori_signal,lowband,highband)

fs=150;
passband(1) = lowband;
passband(2) = highband;

N = length(ori_signal);
y = fft(ori_signal);

lowicut = round(passband(1)*N/fs);
lowmirror = N-lowicut+2;

highicut =  round(passband(2)*N/fs);
highmirror = N-highicut+2;

y([1:(lowicut-1) (lowmirror+1):end])=0;
y((highicut+1):(highmirror-1))=0;

filtersignal = ifft(y);


