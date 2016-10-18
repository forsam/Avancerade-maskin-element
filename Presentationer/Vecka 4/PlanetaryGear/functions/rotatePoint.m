function out = rotatePoint( object, angle, point )
Rotate =@(a) [cos(a),-sin(a); sin(a),cos(a)];
out =  (object - point)*Rotate(angle);
end

