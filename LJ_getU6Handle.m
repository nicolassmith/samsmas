function ljHandle = LJ_getU6Handle(LJadd)

if nargin<1
    LJadd = '1';
end

run LJ_getGlobals
%LJip = '18.161.1.101';

[Error ljHandle] = ljud_OpenLabJack(LJ_dtU6,LJ_ctUSB,LJadd,1); % Returns ljHandle for open LabJack
Error_Message(Error) % Check for and display any Errors

end