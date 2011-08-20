
LJ_setup() % setup the labjack environment

ljHandle = LJ_getU6Handle();

if(~ljHandle)
    error('Didn''t find labjack')
end

% Variable list for configuration
channels = [0:6];
samplerate = 512; % Set scan rate
refreshtime = 2; 
buffer = 10*refreshtime;
resBits = 5; %bit resolution
timeout = inf;
log2bins = 10;

LJ_configureStream(ljHandle,channels,samplerate,buffer,resBits) %10V bipolar is hardcoded

LJ_streamSpectrumPlot(ljHandle,channels,samplerate,refreshtime,log2bins,timeout)