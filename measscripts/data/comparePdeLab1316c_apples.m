
close all

% load data to compare
underpde = load('underpde-20110823T185645');
lab1316c = load('lab1316c-20110824T204920');

pdeSamplerate = underpde.samplerate;
lab1316cSamplerate = lab1316c.samplerate;

log2bins = 13;

specpde = @(d)asd(d,pdeSamplerate,pdeSamplerate/2^log2bins);
speclab1316c = @(d)asd(d,lab1316cSamplerate,lab1316cSamplerate/2^log2bins);

% channel - signal  -  colomn
% AIN0      MAG X      1
% AIN1      MAG Y      2
% AIN2      MAG Z      3
% AIN3      GURALP NS  4
% AIN4      GURALP EW  5
% AIN5      GURALP UD  6
% AIN6      ADC NOISE  7

% compare magnitude magnetometer measurements
magpde = specpde(sqrt(underpde.out(:,1).^2+underpde.out(:,2).^2+underpde.out(:,3).^2));
mag1316c = speclab1316c(sqrt(lab1316c.out(:,1).^2+lab1316c.out(:,2).^2+lab1316c.out(:,3).^2));
noise1316c = speclab1316c(lab1316c.out(:,7));
noisepde = specpde(underpde.out(:,7));


magcal = 0.1;% uT/V

figure('Position',[1,1,600,800])
subplot(2,1,1)
loglog(magpde.f,magpde.x*magcal,'b',mag1316c.f,mag1316c.x*magcal,'r')%,noise1316c.f,noise1316c.x*magcal,'k',noisepde.f,noisepde.x*magcal,'g')
legend('Under PDE (7:00PM)','Lab 1316c (9:00PM)')
title('Magnetometer \surd(x^2+y^2+z^2)')
xlabel('frequency (Hz)')
axis tight
ylabel('Magnetic Field (uT/\surdHz)')
grid on
subplot(2,1,2)
loglog(f,mag1316c.x./magpde.x,'k')
title('ratio')
xlim([min(f) max(f)])
xlabel('frequency (Hz)')
grid on

export_fig comparePdeLab1316c_applesMAG.pdf -painters

% compare vertical guralp measurements
gurUDpde = specpde(underpde.out(:,6));
gurUD1316c = speclab1316c(lab1316c.out(:,6));

f = gurUDpde.f;

gurcal = 1/(26*400*2)./f;% m/V

figure('Position',[1,1,600,800])
subplot(2,1,1)
loglog(f,gurUDpde.x.*gurcal,'b',f,gurUD1316c.x.*gurcal,'r')
legend('Under PDE (7:00PM)','Lab 1316c (9:00PM)')
title('Guralp Vertical')
xlabel('frequency (Hz)')
axis tight
xlim([min(f) max(f)])
ylabel('Ground Motion (m/\surdHz)')
grid on
subplot(2,1,2)
loglog(f,gurUD1316c.x./gurUDpde.x,'k')
title('ratio')
xlim([min(f) max(f)])
xlabel('frequency (Hz)')
grid on

export_fig comparePdeLab1316c_applesGUD.pdf -painters

% compare horizontal guralp measurements
gurNSpde = specpde(underpde.out(:,4));
gurNS1316c = speclab1316c(lab1316c.out(:,4));

f = gurNSpde.f;

gurcal = 1/(26*400*2)./f;% m/V

figure('Position',[1,1,600,800])
subplot(2,1,1)
loglog(f,gurNSpde.x.*gurcal,'b',f,gurNS1316c.x.*gurcal,'r')
legend('Under PDE (7:00PM)','Lab 1316c (9:00PM)')
title('Guralp Horizontal')
xlabel('frequency (Hz)')
axis tight
xlim([min(f) max(f)])
ylabel('Ground Motion (m/\surdHz)')
grid on
subplot(2,1,2)
loglog(f,gurNS1316c.x./gurNSpde.x,'k')
title('ratio')
xlim([min(f) max(f)])
xlabel('frequency (Hz)')
grid on

export_fig comparePdeLab1316c_applesGNS.pdf -painters
