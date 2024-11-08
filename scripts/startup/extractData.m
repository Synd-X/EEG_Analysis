function extractData(zipFile, extractDir, logFile)
    % Extract zip file to specified directory
    try
        unzip(zipFile, extractDir);
        logMessage(logFile, sprintf('Data extracted to: %s', extractDir));
    catch ME
        logMessage(logFile, sprintf('Error during extraction: %s', ME.message));
        rethrow(ME);
    end
end
