function LJ_configureStream(ljHandle,channels,ScanRate,buffer,resBits)

% 10V bipolar is hardcoded at the moment

run LJ_getGlobals

% Configure resolution
Error = ljud_AddRequest(ljHandle,LJ_ioPUT_CONFIG,LJ_chAIN_RESOLUTION,resBits,0,0);
Error_Message(Error)

% Configure Scan Rate
Error = ljud_AddRequest(ljHandle,LJ_ioPUT_CONFIG,LJ_chSTREAM_SCAN_FREQUENCY,ScanRate,0,0);
Error_Message(Error)
 
% Configure Buffer in Samples (ScanRate * NChannels * buffer time)
buffersamp = ScanRate * length(channels)*buffer;
Error = ljud_AddRequest(ljHandle,LJ_ioPUT_CONFIG,LJ_chSTREAM_BUFFER_SIZE,buffersamp,0,0);
Error_Message(Error)

% Configure reads to retrieve whatever data is available without waiting
Error = ljud_AddRequest(ljHandle,LJ_ioPUT_CONFIG,LJ_chSTREAM_WAIT_MODE,LJ_swNONE,0,0);
Error_Message(Error)

% Clear stream channels
Error = ljud_AddRequest(ljHandle,LJ_ioCLEAR_STREAM_CHANNELS,0,0,0,0);
Error_Message(Error)

for i = channels
    % Configure with Bipolar ±10 volt range
    Error = ljud_AddRequest(ljHandle,LJ_ioPUT_AIN_RANGE,i,LJ_rgBIP10V,0,0);
    Error_Message(Error)

    % Define the scan list
    Error = ljud_AddRequest(ljHandle,LJ_ioADD_STREAM_CHANNEL,i,0,0,0);
    Error_Message(Error)
end

% Execute list of above requests
Error = ljud_GoOne(ljHandle);
Error_Message(Error)

%--------------------------------------------------------------------------
% Get all results just to check for errors
Error = ljud_GetFirstResult(ljHandle,0,0,0,0,0);
Error_Message (Error)

% Run while loop until Error 1006 is returned to ensure that the device has
% fully configured its channels before continuing.
while (Error ~= 1006) % 1006 Equates to LJE_NO_MORE_DATA_AVAILABLE
    Error = ljud_GetNextResult(ljHandle,0,0,0,0,0);
    if ((Error ~= 0) && (Error ~= 1006))
        Error_Message (Error)
        break
    end
end 



end