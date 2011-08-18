function [output,Error] = LJ_streamBurst(ljHandle,samples,numchans)

%run LJ_getGlobals
global LJ_ioGET_STREAM_DATA
global LJ_chALL_CHANNELS
array = zeros(samples*numchans);

[Error returnSamples array] = ljud_eGet_array(ljHandle,LJ_ioGET_STREAM_DATA,LJ_chALL_CHANNELS,samples,array);
Error_Message(Error)

output = reshape(array(1:numchans*returnSamples),numchans,[]).'; 

if any(any(output>5))
    disp('saturating')
    disp('...')
end

end