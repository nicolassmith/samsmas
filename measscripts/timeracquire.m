
disp('timer started...')


while 1
    timers = {'02:00:00','08:00:00','12:00:00','17:00:00'};

    timervec = datevec(timers);
    
    nowvec = datevec(now);
    % check for matching hour
    match = find(timervec(:,4) == nowvec(4));
    
    for j = 1:length(match)
        % check if minute and second match also
        if timervec(match(j),5)==nowvec(5) && timervec(match(j),6)==floor(nowvec(6))
            % then run the acquire script
            disp(['buzzzz! timer activated, time is ' datestr(now)])
            
            acquiresave
            
            pause(1)
            break
        end
    end
    
    pause(0.5);
end