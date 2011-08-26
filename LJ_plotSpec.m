function handles = LJ_plotSpec(streamdata,samplerate,log2bins,columns,calibration,plotcommand)

    if nargin<6
        plotcommand = @loglog;
    end
    
    if nargin<5
        calibration = 1;
    end
    
    if nargin<4
        columns = 1:size(streamdata,2);
    end
    
    washold = 0;
    if ishold
        washold = 1;
    end
    
    handles = [];
    
    for jCol = columns
        thisspec = asd(streamdata(:,jCol),samplerate,samplerate/2^log2bins);

        if isnumeric(calibration)
            plotcal = calibration;
        else
            plotcal = calibration(thisspec.f);
        end
        
        handles = [handles;plotcommand(thisspec.f,thisspec.x.*plotcal)]; %#ok<AGROW>
        hold all
    end
    
    if ~washold
        hold off
    end

end