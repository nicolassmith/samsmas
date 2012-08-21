
log2bins = 13;

% channel - signal  -  colomn
% AIN0      MAG X      1
% AIN1      MAG Y      2
% AIN2      MAG Z      3
% AIN3      GURALP NS  4
% AIN4      GURALP EW  5
% AIN5      GURALP UD  6
% AIN6      ADC NOISE  7

magcal = 10;% uT/V
gurcal = @(f)1/(26*400*2)./f;% m/V


% seismic vertical
useTitle = [labtitle ' Guralp Vertical'];
useYlabel = 'Ground Motion (m/\surdHz)';
useCal = gurcal;
useCol = 6;
useFilename = 'seivert';

figure('Position',[1,1,600,800])
set(gcf,'Color','white')

subplot(2,1,1)
for iset = {lab02 lab08 lab12 lab16 pde}
    dataset=iset{1};
    LJ_plotSpec(dataset.out,dataset.samplerate,log2bins,useCol,useCal);
    hold all
    
end
LJ_plotSpec(lab02.out,lab02.samplerate,log2bins,7,useCal);
hold off
title(useTitle)
xlabel('frequency (Hz)')
axis tight
% axis tight not working hack
fmin = min(cellfun(@min,get(findall(gcf,'type','line'),'xdata')));
fmax = max(cellfun(@max,get(findall(gcf,'type','line'),'xdata')));
xlim([fmin fmax])
ylabel(useYlabel)
%legend('Original','Closed Pot Cover','In Foam Housing','In Box','Fans Off')
legend('02AM','08AM','12PM','04PM','pde 7PM','ADC noise','Location','southwest')
grid on

% plot ratios

% calculate reference spectrum
refspec = asd(pde.out(:,useCol),pde.samplerate,pde.samplerate/2^log2bins);

subplot(2,1,2)
for dataset = [lab02 lab08 lab12 lab16]
    LJ_plotSpec(dataset.out,dataset.samplerate,log2bins,useCol,1./refspec.x);
    hold all
    
end
hold off
title('ratio')
xlabel('frequency (Hz)')
axis tight
legend('02','08','12','16','Location','northwest')
grid on

export_fig(['compareTimes' labtitle '-' useFilename '.pdf'],'-painters')

% seismic horizontal
useTitle = [labtitle ' Guralp Horizontal'];
useYlabel = 'Ground Motion (m/\surdHz)';
useCal = gurcal;
useCol = 5;
useFilename = 'seihorz';

figure('Position',[1,1,600,800])
set(gcf,'Color','white')

subplot(2,1,1)
for iset = {lab02 lab08 lab12 lab16 pde}
    dataset=iset{1};
    LJ_plotSpec(dataset.out,dataset.samplerate,log2bins,useCol,useCal);
    hold all
    
end
LJ_plotSpec(lab02.out,lab02.samplerate,log2bins,7,useCal);
hold off
title(useTitle)
xlabel('frequency (Hz)')
axis tight
% axis tight not working hack
fmin = min(cellfun(@min,get(findall(gcf,'type','line'),'xdata')));
fmax = max(cellfun(@max,get(findall(gcf,'type','line'),'xdata')));
xlim([fmin fmax])
ylabel(useYlabel)
%legend('Original','Closed Pot Cover','In Foam Housing','In Box','Fans Off')
legend('02AM','08AM','12PM','04PM','pde 7PM','ADC noise','Location','southwest')
grid on

% plot ratios

% calculate reference spectrum
refspec = asd(pde.out(:,useCol),pde.samplerate,pde.samplerate/2^log2bins);

subplot(2,1,2)
for dataset = [lab02 lab08 lab12 lab16]
    LJ_plotSpec(dataset.out,dataset.samplerate,log2bins,useCol,1./refspec.x);
    hold all
    
end
hold off
title('ratio')
xlabel('frequency (Hz)')
axis tight
legend('02','08','12','16','Location','northwest')
grid on

export_fig(['compareTimes' labtitle '-' useFilename '.pdf'],'-painters')

% magnetic field magnitude
useTitle = [labtitle ' Magnetic Field Magnitude'];
useYlabel = 'Magnetic field (uT/\surdHz)';
useCal = magcal;
%useCol = 5;
useFilename = 'mag';

figure('Position',[1,1,600,800])
set(gcf,'Color','white')

subplot(2,1,1)
avgmag = [];
for iset = {lab02 lab08 lab12 lab16 pde}
    dataset=iset{1};
    dataset.magmag = sqrt(dataset.out(:,1).^2+dataset.out(:,2).^2+dataset.out(:,3).^2);
    avgmag = [avgmag;useCal*mean(dataset.magmag)]; %#ok<AGROW>
    LJ_plotSpec(dataset.magmag,dataset.samplerate,log2bins,1,useCal);
    hold all
    
end
LJ_plotSpec(lab02.out,lab02.samplerate,log2bins,7,useCal);
hold off
title(useTitle)
xlabel('frequency (Hz)')
axis tight
% axis tight not working hack
fmin = min(cellfun(@min,get(findall(gcf,'type','line'),'xdata')));
fmax = max(cellfun(@max,get(findall(gcf,'type','line'),'xdata')));
xlim([fmin fmax])
ylabel(useYlabel)
%legend('Original','Closed Pot Cover','In Foam Housing','In Box','Fans Off')
legend(['02AM, DC=' num2str(round(avgmag(1))) 'uT'],['08AM DC=' num2str(round(avgmag(2))) 'uT'],...
    ['12PM DC=' num2str(round(avgmag(3))) 'uT'],['04PM DC=' num2str(round(avgmag(4))) 'uT'],...
    ['pde 7PM DC=' num2str(round(avgmag(5))) 'uT'],'ADC noise','Location','northwest')
grid on

% plot ratios

% calculate reference spectrum
pdemagmag = sqrt(dataset.out(:,1).^2+dataset.out(:,2).^2+dataset.out(:,3).^2);
refspec = asd(pdemagmag,pde.samplerate,pde.samplerate/2^log2bins);

subplot(2,1,2)
for dataset = [lab02 lab08 lab12 lab16]
    dataset.magmag = sqrt(dataset.out(:,1).^2+dataset.out(:,2).^2+dataset.out(:,3).^2);
    LJ_plotSpec(dataset.magmag,dataset.samplerate,log2bins,1,1./refspec.x);
    hold all
    
end
hold off
title('ratio')
xlabel('frequency (Hz)')
axis tight
legend('02','08','12','16','Location','northwest')
grid on

export_fig(['compareTimes' labtitle '-' useFilename '.pdf'],'-painters')
