function compressCollectedData(tempCollectDir)
    % Compresses the collected data into a zip file at a user-specified location.
    
    fprintf('Please choose a location to save the collected data archive.\n');
    [fileName, pathName] = uiputfile('*.zip', 'Save Collected Data As');
    if isequal(fileName, 0) || isequal(pathName, 0)
        fprintf('User canceled the save operation.\n');
    else
        % Create the zip file
        zipFileName = fullfile(pathName, fileName);
        fprintf('Compressing collected files into %s...\n', zipFileName);
        zip(zipFileName, tempCollectDir);
        fprintf('Data collection and compression complete: %s\n', zipFileName);
    end
end
