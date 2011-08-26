
close all

% load data to compare
nochange = load('lab1316c_nochange-20110825T182143');
infoam = load('lab1316c_infoam-20110825T183138');
inbox = load('lab1316c_inbox-20110825T183548');
closepot = load('lab1316c_closepot-20110825T182526');
nofans = load('lab1316c_nofans-20110825T184121');

log2bins = 13;

% channel - signal  -  colomn
% AIN0      MAG X      1
% AIN1      MAG Y      2
% AIN2      MAG Z      3
% AIN3      GURALP NS  4
% AIN4      GURALP EW  5
% AIN5      GURALP UD  6
% AIN6      ADC NOISE  7



j = 1;

for set = [nochange closepot infoam inbox nofans]
    samplerate = set.samplerate;
    spec = @(d)asd(d,samplerate,samplerate/2^log2bins);
    

    
    thisspec = spec(set.out(:,6));
    f = thisspec.f;
    
    gurcal = 1/(26*400*2)./f;% m/V
    plotspec(:,j) = thisspec.x.*gurcal; %#ok<SAGROW,AGROW>
    j = j + 1;
end


figure('Position',[1,1,600,800])
loglog(f,plotspec)
%legend('Under PDE (7:00PM)','Lab 1316c (2:30PM)')
title('Guralp Vertical')
xlabel('frequency (Hz)')
axis tight
xlim([min(f) max(f)])
ylabel('Ground Motion (m/\surdHz)')
legend('Original','Closed Pot Cover','In Foam Housing','In Box','Fans Off')
grid on

export_fig compareLab1316c_acoustic.pdf -painters
