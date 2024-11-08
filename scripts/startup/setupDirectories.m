function setupDirectories(rootDir, backupDir, subjectsDir, metadataDir, docsDir, logFile, hWaitbar, stepNum, totalSteps)
    % Create directories if they do not exist and update the waitbar
    dirs = {rootDir, backupDir, subjectsDir, metadataDir, docsDir};
    for i = 1:length(dirs)
        if ~exist(dirs{i}, 'dir')
            mkdir(dirs{i});
            logMessage(logFile, sprintf('Created directory: %s', dirs{i}));
        end
    end
    waitbar(stepNum / totalSteps, hWaitbar, 'Setting up directories...');
end
