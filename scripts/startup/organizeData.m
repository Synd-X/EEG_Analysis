function organizeData(extractDir, rootDir, subjectsDir, metadataDir, docsDir)
    % Move subject-info.csv to rootDir
    movefile(fullfile(extractDir, 'subject-info.csv'), rootDir);

    % Organize subject files
    for subjNum = 0:35
        subjDir = fullfile(subjectsDir, sprintf('Subject%02d', subjNum));
        if ~exist(subjDir, 'dir')
            mkdir(subjDir);
        end
        for state = 1:2
            fileName = sprintf('Subject%02d_%d.edf', subjNum, state);
            srcFile = fullfile(extractDir, fileName);
            if exist(srcFile, 'file')
                movefile(srcFile, subjDir);
                fprintf('Moved %s to %s\n', fileName, subjDir);
            else
                fprintf('Warning: %s not found.\n', fileName);
            end
        end
    end

    % Move metadata files
    movefile(fullfile(extractDir, 'README.txt'), docsDir);
    movefile(fullfile(extractDir, 'RECORDS'), metadataDir);
    movefile(fullfile(extractDir, 'SHA256SUMS.txt'), metadataDir);
end
