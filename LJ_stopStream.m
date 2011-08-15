function LJ_stopStream(ljHandle)

run LJ_getGlobals

% Stop the stream
[Error] = ljud_ePut(ljHandle,LJ_ioSTOP_STREAM,0,0,0);
Error_Message(Error)
%--------------------------------------------------------------------------

end