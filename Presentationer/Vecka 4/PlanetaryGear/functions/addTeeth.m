function [ body ] = addTeeth( body, teeth, size)

k = length(body.XData)/teeth;
k = floor(k/2);
for i = 1:length(body.XData)
    if mod(i,k) == 0
        size = -size;
    end
    body.XData(i) = body.XData(i)*(1 + size);
    body.YData(i) = body.YData(i)*(1 + size);
end

end

