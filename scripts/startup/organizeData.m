function organizeData(extractDir, rootDir, subjectsDir, metadataDir, docsDir, logFile, hWaitbar, stepNum, totalSteps)
    % Organize extracted data with logging and progress indication
    
    waitbar(stepNum / totalSteps, hWaitbar, 'Organizing data...');
    
    % Move subject-info.csv if it exists
    csvFilePath = fullfile(extractDir, 'subject-info.csv');
    if exist(csvFilePath, 'file')
        movefile(csvFilePath, rootDir);
        logMessage(logFile, sprintf('Moved %s to %s', 'subject-info.csv', rootDir));
    else
        logMessage(logFile, sprintf('File %s not found in %s. Skipping move.', 'subject-info.csv', extractDir));
    end

    % Organize subject files
    for subjNum = 0:35
        subjDir = fullfile(subjectsDir, sprintf('Subject%02d', subjNum));
        if ~exist(subjDir, 'dir')
            mkdir(subjDir);
        end
        for state = 1:2
            fileName = sprintf('Subject%02d_%d.edf', subjNum, state);
            srcFile = fullfile(extractDir, fileName);
            if exist(srcFile, 'file')
                movefile(srcFile, subjDir);
                logMessage(logFile, sprintf('Moved %s to %s', fileName, subjDir));
            else
                logMessage(logFile, sprintf('Warning: %s not found.', fileName));
            end
        end
    end

    % Move metadata files
    metadataFiles = {'README.txt', 'RECORDS', 'SHA256SUMS.txt'};
    for i = 1:length(metadataFiles)
        srcFile = fullfile(extractDir, metadataFiles{i});
        if exist(srcFile, 'file')
            movefile(srcFile, metadataDir);
            logMessage(logFile, sprintf('Moved %s to %s', metadataFiles{i}, metadataDir));
        else
            logMessage(logFile, sprintf('File %s not found. Skipping move.', metadataFiles{i}));
        end
    end
    waitbar((stepNum + 1) / totalSteps, hWaitbar, 'Data organization complete.');
end
