% shutdown.m - Script to orchestrate project data collection, compression, and cleanup.

% Define the project directory (adjust as necessary)
projectDir = pwd; % Assumes the current directory is the project root

% Step 1: Collect all project data into a temporary directory
tempCollectDir = collectProjectData(projectDir);

% Step 2: Compress the collected data into a user-specified zip file
compressCollectedData(tempCollectDir);

% Step 3: Clean up the temporary collection directory
cleanUpTemporaryDir(tempCollectDir);

fprintf('Project shutdown complete.\n');
