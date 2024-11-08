% Define paths
projectDir = pwd;
dataDir = fullfile(projectDir, 'data');
backupDir = fullfile(dataDir, 'backup');
subjectsDir = fullfile(dataDir, 'subjects');
metadataDir = fullfile(dataDir, 'metadata');
docsDir = fullfile(projectDir, 'docs');
logFile = fullfile(projectDir, 'startup.log');
zipUrl = 'https://physionet.org/static/published-projects/eegmat/eeg-during-mental-arithmetic-tasks-1.0.0.zip';
zipFileName = fullfile(backupDir, 'eeg_data.zip');

% Initialize progress bar
totalSteps = 5;
hWaitbar = waitbar(0, 'Initializing...');

try
    % Step 1: Setup directories
    stepNum = 1;
    setupDirectories(dataDir, backupDir, subjectsDir, metadataDir, docsDir, logFile, hWaitbar, stepNum, totalSteps);

    % Step 2: Download data with progress bar
    stepNum = 2;
    waitbar(stepNum / totalSteps, hWaitbar, 'Downloading data...');
    downloadWithProgress(zipUrl, zipFileName, logFile);

    % Step 3: Extract data
    stepNum = 3;
    waitbar(stepNum / totalSteps, hWaitbar, 'Extracting data...');
    extractData(zipFileName, dataDir, logFile);

    % Step 4: Organize data
    stepNum = 4;
    waitbar(stepNum / totalSteps, hWaitbar, 'Organizing data...');
    organizeData(dataDir, subjectsDir, metadataDir, docsDir, logFile);

    % Step 5: Initialize tools (e.g., Signal Analyzer)
    stepNum = 5;
    waitbar(stepNum / totalSteps, hWaitbar, 'Initializing tools...');
    initializeSignalAnalyzer(subjectsDir, logFile);

    % Finalize
    waitbar(1, hWaitbar, 'Setup complete.');
    pause(1); % Brief pause to display completion
catch ME
    % Log the error and rethrow
    logMessage(logFile, sprintf('Error: %s', ME.message));
    rethrow(ME);
end

% Close the waitbar
if exist('hWaitbar', 'var') && ishandle(hWaitbar)
    close(hWaitbar);
end
