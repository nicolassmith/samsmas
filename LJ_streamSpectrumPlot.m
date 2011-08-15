function LJ_streamSpectrumPlot(ljHandle,channels,samplerate,refreshtime,log2bins,timeout,plotcallback)
if nargin<7 || isempty(plotcallback)
    plotcallback = [];
end

if nargin<6 || isempty(timeout);
    timeout = inf;
end
if nargin<5 || isempty(log2bins);
    log2bins = 10;
end
if nargin<4 || isempty(refreshtime);
    refreshtime = 1;
end

numchans = length(channels);
plotsamples = floor(samplerate*refreshtime);

tic
LJ_startStream(ljHandle)

fighandle = figure;


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
        spec = asd(output(:,j),samplerate,samplerate/2^log2bins);
        plots{j} = [spec.f,spec.x]; %#ok<AGROW>
        leg{j} = ['chan AIN' num2str(channels(j))]; %#ok<AGROW>
    end
    
    if ~ishandle(fighandle)
        break
    end
    figure(fighandle)
    SRSspec(plots{:})
    ylabel('V/\surdHz')
    legend(leg);
    plotcallback(); %#ok<NOEFF>
end


LJ_stopStream(ljHandle)

end