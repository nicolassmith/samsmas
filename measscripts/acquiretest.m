
LJ_setup() % setup the labjack environment

ljHandle = LJ_getU9EthernetHandle('18.161.1.101');

% Variable list for configuration
num_channels = 6;
ScanRate = 512; % Set scan rate
time = 0.5;
buffer = 5; % 5 second buffer time
resBits = 14; %bit resolution

LJ_configureStream(ljHandle,0:num_channels-1,ScanRate,buffer,resBits) %5V bipolar is hardcoded

LJ_startStream(ljHandle)

datas = zeros(0,num_channels);
tic
while toc<5
   
    samples = ScanRate * time; % fudge factor of 2
    
    %pause(time)
     
    output = LJ_streamBurst(ljHandle,samples,num_channels);
    
    datas = [ datas ; output ]; %#ok<AGROW>
    
end


LJ_stopStream(ljHandle)


totalSamples = size(datas,1);



j = ((1:totalSamples)/ScanRate).';
    
% Display the data
disp ('Total Number of data points per Channel:') 
disp (totalSamples)


for j = 1:num_channels
    poo = asd(datas(:,j),ScanRate,ScanRate/2^10);
    spec{j} = [poo.f,poo.x]; %#ok<AGROW>
end

SRSspec(spec{:})

ylabel('V/\surdHz')
%table = [j datas];




%disp('  Time(sec)   AIN0      AIN1      AIN2      AIN3')
%disp(table)

