function LJ_reset(ljHandle)

    [ljError] = calllib('labjackud','ResetLabJack',ljHandle);
    disp('resetting labjack...')
    
    Error_Message(ljError)
    pause(5)

end