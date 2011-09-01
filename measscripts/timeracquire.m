
disp('timer started...')


while 1
    timers = {'02:00:00','08:00:00','12:00:00','16:30:00'};

    timervec = datevec(timers);
    
    nowvec = datevec(now);
    
    % this checks that the current time (seconds truncated) matches one of
    % the timers.
    if any(all((timervec(:,4:6)==repmat(floor(nowvec(4:6)),size(timervec,1),1)).'))
        % then run the acquire script
        disp(['buzzzz! timer activated, time is ' datestr(now)])

        acquiresave

        pause(1)
    end

    
    pause(0.5);
end