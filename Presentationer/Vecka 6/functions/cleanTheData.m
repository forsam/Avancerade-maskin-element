function data = cleanTheData( data )

    hold = 0;
    for i = 2:length(data.fuelweight.value)
    
        if hold
            ending = i;
        else
            ending = i;
            starting = i-1;          
        end
        
        deltaF = data.fuelweight.value(ending) - data.fuelweight.value(starting);
        
        if deltaF >= 0
            hold = 1;
        else
            deltaT = data.time.sumValue(ending) - data.time.sumValue(starting);
            data.fuelCon.value((starting+1):ending) = deltaF/deltaT;
            hold = 0;
        end
        
    end    

    data.fuelCon.value((starting+1):ending) = 0;
    
    % and then send this through a lowpassfilter!
    data.fuelCon.value100 = smoother(data.fuelCon.value, 100);

end

