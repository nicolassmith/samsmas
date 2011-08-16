
LJ_setup() % setup the labjack environment

ljHandle = LJ_getU9EthernetHandle('18.161.1.101');

if(~ljHandle)
    error('Didn''t find labjack')
end

% Variable list for configuration
channels = [2,0,1,3];
samplerate = 512; % Set scan rate
refreshtime = 1; 
buffer = 10*refreshtime;
resBits = 14; %bit resolution
timeout = inf;
log2bins = 8;

LJ_configureStream(ljHandle,channels,samplerate,buffer,resBits) %5V bipolar is hardcoded

LJ_streamSpectrumPlot(ljHandle,channels,samplerate,refreshtime,log2bins,timeout)