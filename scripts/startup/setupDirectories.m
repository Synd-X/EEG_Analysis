function setupDirectories(rootDir, backupDir, subjectsDir, metadataDir, docsDir, tempCollectDir, logFile, hWaitbar, stepNum, totalSteps)
    % Create directories if they do not exist and update the waitbar
    dirs = {rootDir, backupDir, subjectsDir, metadataDir, docsDir, tempCollectDir};
    for i = 1:length(dirs)
        if ~exist(dirs{i}, 'dir')
            mkdir(dirs{i});
            logMessage(logFile, sprintf('Created directory: %s', dirs{i}));
        else
            logMessage(logFile, sprintf('Directory already exists: %s', dirs{i}));
        end
    end
    if nargin > 7 && ishandle(hWaitbar)  % Check if hWaitbar is provided and valid
        waitbar(stepNum / totalSteps, hWaitbar, 'Setting up directories...');
    end
end
