% Define paths
projectDir = pwd;
dataDir = fullfile(projectDir, 'data');
subjectsDir = fullfile(dataDir, 'subjects');
metadataDir = fullfile(dataDir, 'metadata');
docsDir = fullfile(projectDir, 'docs');
zipUrl = 'https://physionet.org/static/published-projects/eegmat/eeg-during-mental-arithmetic-tasks-1.0.0.zip';
zipFileName = fullfile(dataDir, 'eeg_data.zip');
logFile = fullfile(projectDir, 'startup.log');

% Initialize logging
logMessage(logFile, 'Starting project setup...');

% Initialize progress bar
hWaitbar = waitbar(0, 'Initializing...');

% Step 1: Setup directories
waitbar(0.1, hWaitbar, 'Setting up directories...');
setupDirectories(dataDir, subjectsDir, metadataDir, docsDir, logFile);
logMessage(logFile, 'Directories setup complete.');

% Step 2: Download data with progress bar
waitbar(0.3, hWaitbar, 'Downloading data...');
downloadWithProgress(zipUrl, zipFileName, logFile);
logMessage(logFile, 'Data download complete.');

% Step 3: Extract data
waitbar(0.5, hWaitbar, 'Extracting data...');
unzip(zipFileName, dataDir);
logMessage(logFile, 'Data extraction complete.');

% Step 4: Organize data
waitbar(0.7, hWaitbar, 'Organizing data...');
organizeData(dataDir, subjectsDir, metadataDir, docsDir, logFile);
logMessage(logFile, 'Data organization complete.');

% Step 5: Initialize Signal Analyzer
waitbar(0.9, hWaitbar, 'Initializing Signal Analyzer...');
initializeSignalAnalyzer(subjectsDir);
logMessage(logFile, 'Signal Analyzer initialization complete.');

% Finalize
waitbar(1.0, hWaitbar, 'Setup complete.');
pause(1); % Brief pause to display completion
close(hWaitbar);
logMessage(logFile, 'Project setup complete.');
