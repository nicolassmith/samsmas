function [output,err] = LJ_streamOut(ljHandle,samples,numchans,bursttime)
if nargin<4
    bursttime = 0.2;
end

LJ_startStream(ljHandle)

output = zeros(0,numchans);
samplesleft = samples;
while samplesleft>0
    bursttic = tic;
    [putout,err] = LJ_streamBurst(ljHandle,samplesleft,numchans);
%     if(err)
%         warning('stream failed')
%         break
%     end
    output = [output; putout]; %#ok<AGROW>

    samplesleft = samples-size(output,1);
    while toc(bursttic)<bursttime
        pause(0.01)
    end
end
    
LJ_stopStream(ljHandle)

end