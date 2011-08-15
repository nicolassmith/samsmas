function LJ_setup()
% get the functions


ljud_LoadDriver; % Loads LabJack UD Function Library

run LJ_getGlobals;
ljud_Constants; % Loads LabJack UD constant file

end

