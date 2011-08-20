function LJ_streamStripPlot(ljHandle,channels,samplerate,refreshtime,plotlength,timeout,plotcallback)
if nargin<7 || isempty(plotcallback)
    plotcallback = [];
end

if nargin<6 || isempty(timeout);
    timeout = inf;
end
if nargin<5 || isempty(plotlength);
    plotlength = 10;
end
if nargin<4 || isempty(refreshtime);
    refreshtime = 1;
end


numchans = length(channels);
plotsamples = floor(samplerate*refreshtime);

plotpoints = 1000; % what if they want a really low sample rate?
plotdata = NaN(plotpoints,numchans);
timedata = linspace(-plotlength,0,plotpoints);


for j = 1:numchans
    leg{j} = ['chan AIN' num2str(channels(j))]; %#ok<AGROW>
end

fighandle = figure;
plothandle = plot(timedata,plotdata);
ylabel('V')
xlabel('time (s)')
legend(leg,'Location','NW');
plotcallback(); %#ok<NOEFF>

tic
LJ_startStream(ljHandle)

while toc<timeout
    output = zeros(0,numchans);
    samplesleft = plotsamples;
    while samplesleft>0
        bursttic = tic;
        [putout,err] = LJ_streamBurst(ljHandle,samplesleft,numchans);
        if(err)
            warning('stream failed')
            break
        end
        output = [output; putout]; %#ok<AGROW>
        
        samplesleft = plotsamples-size(output,1);
        while toc(bursttic)<0.2 % burst rate
            pause(0.01)
        end
    end
    
    
    for j = 1:numchans
        decoutput = decimate(output(:,j),ceil(samplerate/plotpoints*plotlength));
        plotdata(:,j) = [plotdata(length(decoutput)+1:end,j);decoutput];
        
        if ~ishandle(plothandle(j))
            break
        end
        set(plothandle(j),'YData',plotdata(:,j));
        
    end
    
    if ~ishandle(fighandle)
        break
    end
    drawnow
end


LJ_stopStream(ljHandle)

end