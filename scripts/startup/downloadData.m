function downloadData(zipUrl, zipFileName, logFile, hWaitbar, stepNum, totalSteps)
    % Download data with progress indication using waitbar and logging
    
    if ~exist(zipFileName, 'file')
        logMessage(logFile, sprintf('Downloading data from %s...', zipUrl));
        waitbar(stepNum / totalSteps, hWaitbar, 'Downloading data...');
        try
            tic;
            options = weboptions('Timeout', 60); % Adjust timeout as needed
            websave(zipFileName, zipUrl, options);
            elapsedTime = toc;
            logMessage(logFile, sprintf('Download complete: %s (Elapsed time: %.2f seconds)', zipFileName, elapsedTime));
            waitbar((stepNum + 1) / totalSteps, hWaitbar, 'Download complete.');
        catch exception
            logMessage(logFile, sprintf('Error during data download: %s', exception.message));
            waitbar((stepNum + 1) / totalSteps, hWaitbar, 'Download failed.');
        end
    else
        logMessage(logFile, sprintf('Data file already exists: %s', zipFileName));
        waitbar((stepNum + 1) / totalSteps, hWaitbar, 'Data file already exists. Skipping download.');
    end
end
