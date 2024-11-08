% Define paths
rootDir = 'data/';
backupDir = fullfile(rootDir, 'backup/');
subjectsDir = fullfile(rootDir, 'subjects/');
metadataDir = fullfile(rootDir, 'metadata/');
docsDir = 'docs/';
zipUrl = 'https://physionet.org/static/published-projects/eegmat/eeg-during-mental-arithmetic-tasks-1.0.0.zip';
zipFileName = fullfile(backupDir, 'eeg_data.zip');

% Setup directories
setupDirectories(rootDir, backupDir, subjectsDir, metadataDir, docsDir);

% Download data
downloadData(zipUrl, zipFileName);

% Extract data
extractData(zipFileName, backupDir);

% Organize data
organizeData(backupDir, rootDir, subjectsDir, metadataDir, docsDir);

% Convert checksums
convertChecksums(metadataDir);

% Verify checksums
verifyChecksums(metadataDir, subjectsDir);

% Initialize Signal Analyzer
initializeSignalAnalyzer(subjectsDir);
