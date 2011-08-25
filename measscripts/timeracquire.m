
disp('timer started...')


while 1
    timers = {'17:00:00','18:00:44','02:00:00','08:00:00','13:00:00'};

    timervec = datevec(timers);
    
    nowvec = datevec(now);
    % check for matching hour
    match = find(timervec(:,4) == nowvec(4));
    % if found and match minute and second then...
    
    for j = 1:length(match)
        if ~isempty(match(j)) && timervec(match(j),5)==nowvec(5) && timervec(match(j),6)==floor(nowvec(6))
            % then run the acquire script
            disp(['buzzzz! timer activated, time is ' datestr(now)])

            pause(1)
        end
    end
    
    pause(0.5);
end