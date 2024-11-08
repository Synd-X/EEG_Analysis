function verifyChecksums(metadataDir, subjectsDir)
    csvFile = fullfile(metadataDir, 'SHA256SUMS.csv');
    if exist(csvFile, 'file')
        fprintf('Verifying file checksums...\n');
        T = readtable(csvFile);
        for i = 1:height(T)
            filePath = fullfile(subjectsDir, T.Filename{i});
            if exist(filePath, 'file')
                fileChecksum = getFileChecksum(filePath);
                if strcmp(fileChecksum, T.Checksum{i})
                    fprintf('Checksum verified for %s\n', T.Filename{i});
                else
                    fprintf('Warning: Checksum mismatch for %s\n', T.Filename{i});
                end
            else
                fprintf('Warning: %s not found.\n', T.Filename{i});
            end
        end
    else
        fprintf('Warning: %s not found.\n', csvFile);
    end
end


