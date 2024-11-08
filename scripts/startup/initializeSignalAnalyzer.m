function initializeSignalAnalyzer(subjectsDir)
    fprintf('Initializing Signal Analyzer...\n');
    
    % Get a list of all subject directories
    subjectFolders = dir(subjectsDir);
    subjectFolders = subjectFolders([subjectFolders.isdir] & ~ismember({subjectFolders.name}, {'.', '..'}));
    
    % Load each subject's data into the Signal Analyzer
    for i = 1:length(subjectFolders)
        subjectDir = fullfile(subjectsDir, subjectFolders(i).name);
        
        % Get a list of .edf files for the subject
        edfFiles = dir(fullfile(subjectDir, '*.edf'));
        
        for j = 1:length(edfFiles)
            edfFilePath = fullfile(subjectDir, edfFiles(j).name);
            fprintf('Loading %s into Signal Analyzer...\n', edfFiles(j).name);
            
            % Read the .edf file using edfread (or a similar function)
            [hdr, record] = edfread(edfFilePath);
            
            % Create a time vector based on the sampling frequency
            fs = hdr.samples(1); % Assuming consistent sampling frequency across channels
            t = (0:length(record)-1) / fs; % Time vector
            
            % Import the signal data into the Signal Analyzer workspace
            signalName = sprintf('%s_%s', subjectFolders(i).name, edfFiles(j).name);
            assignin('base', signalName, record);
            
            % Plot the data in Signal Analyzer
            signalAnalyzer(record); % Opens the Signal Analyzer app with the loaded signal
        end
    end
    
    fprintf('Signal Analyzer initialization complete.\n');
end
