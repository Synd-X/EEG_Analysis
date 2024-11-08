function checksum = getFileChecksum(filePath)
    % Compute SHA-256 checksum of a file
    fileID = fopen(filePath, 'r');
    data = fread(fileID, inf, '*uint8');
    fclose(fileID);
    checksum = DataHash(data, struct('Method', 'SHA-256'));
end