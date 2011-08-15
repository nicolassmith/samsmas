function LJ_startStream(ljHandle)

run LJ_getGlobals

%--------------------------------------------------------------------------
% Start the Stream
Error = ljud_ePut(ljHandle,LJ_ioSTART_STREAM,0,0,0);
Error_Message(Error)

end