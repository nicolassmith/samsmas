
LJ_setup() % setup the labjack environment

ljHandle = LJ_getU6Handle();

if(~ljHandle)
    error('Didn''t find labjack')
end

% Variable list for configuration
channels = [0:6];
samplerate = 512; % Set scan rate
refreshtime = 1; 
buffer = 10;
resBits = 5; %bit resolution
timeout = inf;
timeLength = 10;

LJ_configureStream(ljHandle,channels,samplerate,buffer,resBits) %10V bipolar is hardcoded
legendCallback = @(x)legend('MAG X','MAG Y','MAG Z','GUR NS','GUR EW','GUR UD','grounded','Location','NW');

LJ_streamStripPlot(ljHandle,channels,samplerate,refreshtime,timeLength,timeout,legendCallback)