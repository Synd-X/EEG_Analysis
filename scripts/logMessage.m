function logMessage(logFile, message)
    % Logs a message with a timestamp to the specified log file
    timestamp = datestr(now, 'yyyy-mm-dd HH:MM:SS');
    fid = fopen(logFile, 'a'); % Open file in append mode
    if fid == -1
        warning('Could not open log file: %s', logFile);
        return;
    end
    fprintf(fid, '[%s] %s\n', timestamp, message);
    fclose(fid);
end
