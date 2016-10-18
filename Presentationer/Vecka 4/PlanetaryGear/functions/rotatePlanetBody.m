function [x, y, center] = rotatePlanetBody( xVector,yVector, angle, center, centerAngle)
    Rotate =@(a) [cos(a),-sin(a); sin(a),cos(a)];
    
    
    xVector = xVector - center(1);
    yVector = yVector - center(2);
    
    center = Rotate(centerAngle)*center';
    result = Rotate(angle)*[xVector; yVector];
    
    x = result(1,:) + center(1);
    y = result(2,:) + center(2);
    
end

