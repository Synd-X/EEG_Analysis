function tempCollectDir = collectProjectData(projectDir)
    % Collects data, products, logs, and reports into a temporary directory.
    
    fprintf('Collecting all data, products, logs, and reports...\n');
    
    % Define directories to be collected
    dataDir = fullfile(projectDir, 'data');
    resultsDir = fullfile(projectDir, 'results');
    logsDir = fullfile(projectDir, 'logs');
    docsDir = fullfile(projectDir, 'docs');
    
    % Create a temporary directory for collection
    tempCollectDir = fullfile(projectDir, 'temp_collect');
    if exist(tempCollectDir, 'dir')
        rmdir(tempCollectDir, 's'); % Remove if it already exists
    end
    mkdir(tempCollectDir);
    
    % List of directories to collect
    dirsToCollect = {dataDir, resultsDir, logsDir, docsDir};
    for i = 1:length(dirsToCollect)
        if exist(dirsToCollect{i}, 'dir')
            copyfile(dirsToCollect{i}, tempCollectDir);
            fprintf('Collected: %s\n', dirsToCollect{i});
        end
    end
end
