% Define paths relative to the project directory
projectDir = pwd;
dataDir = fullfile(projectDir, 'data');
backupDir = fullfile(projectDir, 'backup');
subjectsDir = fullfile(dataDir, 'subjects');
metadataDir = fullfile(dataDir, 'metadata');
docsDir = fullfile(projectDir, 'docs');
tempCollectDir = fullfile(projectDir, 'temp_collect');
logFile = fullfile(projectDir, 'logs', 'startup.log');
zipUrl = 'https://physionet.org/static/published-projects/eegmat/eeg-during-mental-arithmetic-tasks-1.0.0.zip';
zipFileName = fullfile(backupDir, 'eeg_data.zip');

% Initialize progress bar
totalSteps = 6; % Incremented to account for temp_collect creation step
hWaitbar = waitbar(0, 'Initializing...');

try
    % Step 1: Setup directories
    stepNum = 1;
    setupDirectories(dataDir, backupDir, subjectsDir, metadataDir, docsDir, tempCollectDir, logFile, hWaitbar, stepNum, totalSteps);

    % Step 2: Download data with progress bar
    stepNum = 2;
    if exist('hWaitbar', 'var') && ishandle(hWaitbar)
        waitbar(stepNum / totalSteps, hWaitbar, 'Downloading data...');
    end
    downloadWithProgress(zipUrl, zipFileName, logFile);

    % Step 3: Extract data
    stepNum = 3;
    if exist('hWaitbar', 'var') && ishandle(hWaitbar)
        waitbar(stepNum / totalSteps, hWaitbar, 'Extracting data...');
    end
    extractData(zipFileName, backupDir, logFile);

    % Step 4: Organize data
    stepNum = 4;
    if exist('hWaitbar', 'var') && ishandle(hWaitbar)
        waitbar(stepNum / totalSteps, hWaitbar, 'Organizing data...');
    end
    organizeData(dataDir, subjectsDir, metadataDir, docsDir, logFile);

    % Step 5: Initialize tools (e.g., Signal Analyzer)
    stepNum = 5;
    if exist('hWaitbar', 'var') && ishandle(hWaitbar)
        waitbar(stepNum / totalSteps, hWaitbar, 'Initializing tools...');
    end
    initializeSignalAnalyzer(subjectsDir, logFile);

    % Step 6: Setup temporary collection directory (if needed)
    stepNum = 6;
    if exist('hWaitbar', 'var') && ishandle(hWaitbar)
        waitbar(stepNum / totalSteps, hWaitbar, 'Setting up temp collection...');
    end
    if ~exist(tempCollectDir, 'dir')
        mkdir(tempCollectDir);
        logMessage(logFile, sprintf('Created temp collection directory: %s', tempCollectDir));
    end

    % Finalize
    if exist('hWaitbar', 'var') && ishandle(hWaitbar)
        waitbar(1, hWaitbar, 'Setup complete.');
        pause(1); % Brief pause to display completion
    end
catch ME
    % Log the error and rethrow
    logMessage(logFile, sprintf('Error: %s', ME.message));
    rethrow(ME);
end

% Close the waitbar
if exist('hWaitbar', 'var') && ishandle(hWaitbar)
    close(hWaitbar);
end
