function power = PowerIce( meanSpeed, power, time, speed )
    
    startDelay = 3;
    
    if time < startDelay;
        power = 0.95*power*time/startDelay + 0.05*power;
    elseif meanSpeed*3.6 > 25.5 || speed*3.6 > 50;
        power = 0;
    else
        power = power;
    end

end

