
LJ_setup() % setup the labjack environment

ljHandle = LJ_getU6Handle();

if(~ljHandle)
    error('Didn''t find labjack')
end

% Variable list for configuration
channels = [3,4,6];
samplerate = 512; % Set scan rate
buffer = 10;
resBits = 5; %bit resolution
runLength = 60;
log2bits = 13;

totalsamples = runLength*samplerate;

LJ_configureStream(ljHandle,channels,samplerate,buffer,resBits) %10V bipolar is hardcoded

out = LJ_streamOut(ljHandle,totalsamples,length(channels));

% channel - signal

% AIN3      GURALP UD
% AIN4      WILCOXON UD
% AIN6      ADC NOISE

spec = @(d)asd(d,samplerate,samplerate/2^log2bits);
coh = @(d1,d2)coherence(d1,d2,samplerate,samplerate/2^log2bits);

gur = spec(out(:,1));
wil = spec(out(:,2));
wilgurcoh = coh(out(:,1),out(:,2));
noise = spec(out(:,3));

wilcal = 0.001;% g/V
gurcal = 1/(26*400*2);% (m/s)/V

figure
subplot(2,1,1)
loglog(gur.f,gur.x*gurcal,noise.f,noise.x*gurcal,'k')
axis tight
legend('Z','ADC noise')
title('Guralp')
xlabel('frequency (Hz)')
ylabel('Ground Motion (m/s)')

subplot(2,1,2)
loglog(wil.f,wil.x*wilcal,'b',noise.f,noise.x*wilcal,'k')
axis tight
legend('Z','ADC Noise')
title('Wilcoxon')
xlabel('frequency (Hz)')
ylabel('Ground Motion (g)')

figure
semilogx(wilgurcoh.f,wilgurcoh.Cxy)
title('Coherence')
xlabel('Frequency (Hz)')
