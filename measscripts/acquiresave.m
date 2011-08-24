clear % clear workspace variables

LJ_setup() % setup the labjack environment

ljHandle = LJ_getU6Handle();

if(~ljHandle)
    error('Didn''t find labjack')
end

% Variable list for configuration
channels = [0:6];
samplerate = 512; % Set scan rate
buffer = 10;
resBits = 5; %bit resolution
runLength = 5*60;

filenameprefix = 'underpde';

totalsamples = runLength*samplerate;

% configure filename to save as

filename = [filenameprefix '-' datestr(now,30)];

LJ_configureStream(ljHandle,channels,samplerate,buffer,resBits) %10V bipolar is hardcoded
disp(['begin data capture for ' filename])
out = LJ_streamOut(ljHandle,totalsamples,length(channels));
disp('saving data...')
save(['data/' filename]);
