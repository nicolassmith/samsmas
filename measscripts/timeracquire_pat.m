
disp('timer started...')


while 1
    timers = {'20:00:00','21:00:00','22:00:00','23:00:00', ...
        '00:00:00','01:00:00','02:00:00','03:00:00','04:00:00','05:00:00','06:00:00','07:00:00','08:00:00'};

    timervec = datevec(timers);
    
    nowvec = datevec(now);
    
    % this checks that the current time (seconds truncated) matches one of
    % the timers.
    %if any(all((timervec(:,4:6)==repmat(floor(nowvec(4:6)),size(timervec,1),1)).'))
     if nowvec(5) == 0 
       % then run the acquire script
        disp(['buzzzz! timer activated, time is ' datestr(now)])

        acquiresave_pat

        pause(1)
    
      end

    
    pause(0.5);
end