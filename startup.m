% Define paths
projectDir = pwd;
dataDir = fullfile(projectDir, 'data');
backupDir = fullfile(dataDir, 'backup');
subjectsDir = fullfile(dataDir, 'subjects');
metadataDir = fullfile(dataDir, 'metadata');
docsDir = fullfile(projectDir, 'docs');
tempCollectDir = fullfile(projectDir, 'temp_collect'); % Temporary collection directory
logFile = fullfile(projectDir, 'startup.log');
zipUrl = 'https://physionet.org/static/published-projects/eegmat/eeg-during-mental-arithmetic-tasks-1.0.0.zip';
zipFileName = fullfile(backupDir, 'eeg_data.zip');

% Total steps for progress tracking
totalSteps = 6;

try
    % Step 1: Setup directories
    stepNum = 1;
    fprintf('Step %d/%d: Setting up directories...\n', stepNum, totalSteps);
    setupDirectories(dataDir, backupDir, subjectsDir, metadataDir, docsDir, tempCollectDir, logFile);

    % Step 2: Download data with progress bar
    stepNum = 2;
    fprintf('Step %d/%d: Downloading data from %s...\n', stepNum, totalSteps, zipUrl);
    downloadWithProgress(zipUrl, zipFileName, logFile);

    % Step 3: Extract data
    stepNum = 3;
    fprintf('Step %d/%d: Extracting data...\n', stepNum, totalSteps);
    extractData(zipFileName, dataDir, logFile);

    % Step 4: Organize data
    stepNum = 4;
    fprintf('Step %d/%d: Organizing data...\n', stepNum, totalSteps);
    organizeData(dataDir, subjectsDir, metadataDir, docsDir, logFile);

    % Step 5: Initialize tools (e.g., Signal Analyzer)
    stepNum = 5;
    fprintf('Step %d/%d: Initializing tools...\n', stepNum, totalSteps);
    initializeSignalAnalyzer(subjectsDir, logFile);

    % Step 6: Setup temporary collection directory (if needed)
    stepNum = 6;
    fprintf('Step %d/%d: Setting up temporary collection directory...\n', stepNum, totalSteps);
    if ~exist(tempCollectDir, 'dir')
        mkdir(tempCollectDir);
        logMessage(logFile, sprintf('Created temp collection directory: %s', tempCollectDir));
    end

    fprintf('Setup complete.\n');
catch ME
    % Log the error and display in terminal
    logMessage(logFile, sprintf('Error: %s', ME.message));
    fprintf('Error: %s\n', ME.message);
end
