%%%%% SETUP BLOCK
clear % clear workspace variables

LJ_setup() % setup the labjack environment

ljHandle = LJ_getU6Handle();

if(~ljHandle)
    error('Didn''t find labjack')
end

m = 60; % minute
h = 60*m; %hour
%%%%% END SETUP BLOCK

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% CONFIGURATION BLOCK %%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

channels = [0:6]; % choose channels to acquire
samplerate = 512; % Set sample rate (Hz)
buffer = 10; % labjack buffer (in seconds)
resBits = 5; % set labjack resolution

% Probably only need to change the following
filenameprefix = 'lab1316c'; %filename prefix (careful, matlab doesn't like names that start with numbers)

runLength = 2*h; % length of time to acquire (seconds) m = 30, h = 3600

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% END CONFIGURATION BLOCK %%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%% DATA ACQUISITION BLOCK
totalsamples = runLength*samplerate;
filename = [filenameprefix '-' datestr(now,30)];

LJ_configureStream(ljHandle,channels,samplerate,buffer,resBits) %10V bipolar is hardcoded
disp(['begin data capture for ' filename])
out = LJ_streamOut(ljHandle,totalsamples,length(channels));
disp('saving data...')
save(['data/' filename]);
%%%%%% END DATA ACQUISITION BLOCK