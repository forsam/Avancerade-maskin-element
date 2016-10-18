function [ vector ] = DrawRing( center, diameter )

    radius = diameter/2;

    vector = zeros(100,2);
    omega = linspace(0,2*pi,100);
    
    vector(:,1) = center(1) + radius.*cos(omega);
    vector(:,2) = center(2) + radius.*sin(omega);

end

