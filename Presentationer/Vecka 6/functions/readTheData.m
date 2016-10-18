function data = readTheData( fileNumber, data )

dontRead = [17, 19, 25, 26];

for file = 1:fileNumber
    if sum(file == dontRead)
        continue
    end
    
    if (file < 10)
        fileName = strcat('punkt00',int2str(file),'.txt');
    else       
        fileName = strcat('punkt0',int2str(file),'.txt'); 
    end
    
    data = readData(fileName,data);
end


end

