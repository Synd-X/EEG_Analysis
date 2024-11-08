function organizeData(dataDir, subjectsDir, metadataDir, docsDir, logFile)
    % Organize extracted data into subjects and metadata directories
    try
        % Move subject-info.csv (if present)
        subjectInfoPath = fullfile(dataDir, 'subject-info.csv');
        if isfile(subjectInfoPath)
            movefile(subjectInfoPath, metadataDir);
            logMessage(logFile, 'Moved subject-info.csv to metadata directory.');
        else
            logMessage(logFile, 'subject-info.csv not found; skipping move operation.');
        end

        % Organize subject files (example logic; adjust as needed)
        edfFiles = dir(fullfile(dataDir, '*.edf'));
        for k = 1:length(edfFiles)
            [~, name, ext] = fileparts(edfFiles(k).name);
            subjectDir = fullfile(subjectsDir, name);
            if ~exist(subjectDir, 'dir')
                mkdir(subjectDir);
            end
            movefile(fullfile(edfFiles(k).folder, [name, ext]), subjectDir);
            logMessage(logFile, sprintf('Moved %s to %s', [name, ext], subjectDir));
        end
    catch ME
        logMessage(logFile, sprintf('Error during data organization: %s', ME.message));
        rethrow(ME);
    end
end
