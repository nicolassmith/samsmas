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

channels = [3:6]; % choose channels to acquire
samplerate = 1024; % Set sample rate (Hz)
buffer = 10; % labjack buffer (in seconds)
resBits = 5; % set labjack resolution

% Probably only need to change the following
filenameprefix = 'opt'; % filename prefix (careful, matlab doesn't like names that start with numbers)
                             % full filename will include date and time.
runLength = 45*m; % length of time to acquire (seconds) m = 60, h = 3600

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% END CONFIGURATION BLOCK %%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

filename = [filenameprefix '-' datestr(now,30)];


%%%%%% RECORD AUDIO
%%% 5min
system('wav\cmd2wav.exe wav\audio.wav 300 16 1 44100');
wav = wavread('wav\audio.wav');


%%%%%% DATA ACQUISITION BLOCK
totalsamples = runLength*samplerate;

LJ_configureStream(ljHandle,channels,samplerate,buffer,resBits) %10V bipolar is hardcoded
disp(['begin data capture for ' filename ' (' num2str(runLength) ' seconds)'])
out = LJ_streamOut(ljHandle,totalsamples,length(channels));

disp('saving data...')
save(['d:/pat/' filename]);
disp('done.')
%%%%%% END DATA ACQUISITION BLOCK