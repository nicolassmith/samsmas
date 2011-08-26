function plotDataFile(filename)
    % plots data in filename, or prompts user for file.
    
    % channel - signal
    % AIN0      MAG X
    % AIN1      MAG Y
    % AIN2      MAG Z
    % AIN3      GURALP NS
    % AIN4      GURALP EW
    % AIN5      GURALP UD
    % AIN6      ADC NOISE
    
    magcal = 0.1;% uT/V
    gurcal = @(f)1/(26*400*2)./f;% m/V
    
    magcols = [1:3,7];
    gurcols = [4:6,7];
    
    log2bins = 13;
    
    
    if nargin<1
        [filename,PathName,FilterIndex] = uigetfile('data/*.mat','Open file to plot...'); 
        if FilterIndex ==0
            error('didn''t chose file')
        end
    else
        PathName = 'data/';
    end
    
    
    dataset = load([PathName filename]); % load data
    
    figure('Position',[1,1,600,800])
    subplot(2,1,1)
    LJ_plotSpec(dataset.out,dataset.samplerate,log2bins,magcols,magcal);
    legend('X','Y','Z','ADC noise')
    title('Magnetometer')
    xlabel('frequency (Hz)')
    axis tight
    xlim([dataset.samplerate/2^log2bins dataset.samplerate/2])
    ylabel('Magnetic Field (uT/\surdHz)')
    grid on

    subplot(2,1,2)
    LJ_plotSpec(dataset.out,dataset.samplerate,log2bins,gurcols,gurcal);
    axis tight
    legend('NS','EW','UD','ADC Noise')
    title('Guralp')
    xlabel('frequency (Hz)')
    axis tight
    xlim([dataset.samplerate/2^log2bins dataset.samplerate/2])
    ylabel('Ground Motion (m/\surdHz)')
    grid on
end