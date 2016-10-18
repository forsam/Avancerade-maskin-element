function [ body ] = addPlanetTeeth( body, teeth, size, center)

k = length(body.XData)/teeth;
k = floor(k/2);
body.XData = body.XData - center(1);
body.YData = body.YData - center(2);

for i = 1:length(body.XData)
    if mod(i,k) == 0
        size = -size;
    end
    body.XData(i) = body.XData(i)*(1 + size);
    body.YData(i) = body.YData(i)*(1 + size);
end

body.XData = body.XData + center(1);
body.YData = body.YData + center(2);

end




