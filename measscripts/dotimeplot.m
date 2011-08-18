
LJ_setup() % setup the labjack environment

ljHandle = LJ_getU9USBHandle();

if(~ljHandle)
    error('Didn''t find labjack')
end

% Variable list for configuration
channels = [0,6];
samplerate = 512; % Set scan rate
refreshtime = .7; 
buffer = 10;
resBits = 14; %bit resolution
timeout = inf;
length = 10;

LJ_configureStream(ljHandle,channels,samplerate,buffer,resBits) %5V bipolar is hardcoded

LJ_streamStripPlot(ljHandle,channels,samplerate,refreshtime,length,timeout)