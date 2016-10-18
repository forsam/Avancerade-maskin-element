function vector = drawRing( center, diameter , teeth)

omega = linspace(0,2*pi,20*teeth);
startPoint = [center(1), center(2) + diameter/2];
vector = zeros(20*teeth,2);

    for angle = 1:length(omega)
       vector(angle,:) = rotatePoint(startPoint, omega(angle), center);
       vector(angle,1) = vector(angle,1) + center(1);
       vector(angle,2) = vector(angle,2) + center(2);
    end

end

