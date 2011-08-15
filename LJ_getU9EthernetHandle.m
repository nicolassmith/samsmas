function ljHandle = LJ_getU9EthernetHandle(LJip)

run LJ_getGlobals
%LJip = '18.161.1.101';

[Error ljHandle] = ljud_OpenLabJack(LJ_dtUE9,LJ_ctETHERNET,LJip,0); % Returns ljHandle for open LabJack
Error_Message(Error) % Check for and display any Errors

end