% data should be loaded into workspace

% channel - signal
% AIN0      MAG X
% AIN1      MAG Y
% AIN2      MAG Z
% AIN3      GURALP NS
% AIN4      GURALP EW
% AIN5      GURALP UD
% AIN6      ADC NOISE

log2bins = 13;

spec = @(d)asd(d,samplerate,samplerate/2^log2bins);

mx = spec(out(:,1));
my = spec(out(:,2));
mz = spec(out(:,3));
gn = spec(out(:,4));
ge = spec(out(:,5));
gu = spec(out(:,6));
noise = spec(out(:,7));

magcal = 0.1;% uT/V
gurcal = 1/(26*400*2);% (m/s)/V

figure
subplot(2,1,1)
loglog(mx.f,mx.x*magcal,'b',my.f,my.x*magcal,'r',mz.f,mz.x*magcal,'g',noise.f,noise.x*magcal,'k')
axis tight
legend('X','Y','Z','ADC noise')
title('Magnetometer')
xlabel('frequency (Hz)')
ylabel('Magnetic Field (uT)')

subplot(2,1,2)
loglog(gn.f,gn.x*gurcal,'b',ge.f,ge.x*gurcal,'r',gu.f,gu.x*gurcal,'g',noise.f,noise.x*gurcal,'k')
axis tight
legend('NS','EW','UD','ADC Noise')
title('Guralp')
xlabel('frequency (Hz)')
ylabel('Ground Motion (m/s)')

