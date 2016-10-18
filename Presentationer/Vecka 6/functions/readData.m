function [data] = readData( file, data )
% the file is a 4 column file with:
% col 1: Torque [Nm]
% col 2: Rpm
% col 3: fuelweight [g]
% col 4: time [s]

% the data struct is built like that and the data from a file sent with the
% object will be added att the end of the data structs!

% initialize the data struct!
    if(data.init)  
       data.Torque.name = 'Torque';
       data.Rpm.name = 'Rpm';
       data.fuelweight.name = 'Fuel weight';
       data.time.name = 'Time';  
       data.cuts.name = 'data cuts';
    end

% read in data from the file!
    fileID = fopen(file);
    theContent = fscanf(fileID,'%f',[4,inf]);
    fclose(fileID);

% add the content to the data struct
if (data.init)
    data.Torque.value = [theContent(1,:)];
    
    data.Rpm.value = [theContent(2,:)];
    
    data.fuelweight.value = [theContent(3,:)] - theContent(3,1);
    
    data.time.value = [theContent(4,:)];
    data.time.sumValue = data.time.value;
    
    data.cuts.array = length(theContent(4,:));
    
    data.init = 0;
else
    data.Torque.value = [data.Torque.value, theContent(1,:)];
    
    data.Rpm.value = [data.Rpm.value, theContent(2,:)];
    
    data.fuelweight.value = [data.fuelweight.value, theContent(3,:) - theContent(3,1) + data.fuelweight.value(end)]; 
    
    
    data.time.value = [data.time.value, theContent(4,:)];
    data.time.sumValue = [data.time.sumValue, data.time.sumValue(end) + theContent(4,:)];
    
    data.cuts.array = [data.cuts.array, data.cuts.array(end) + length(theContent(4,:))];
end


end

