function convertChecksums(metadataDir)
    txtFile = fullfile(metadataDir, 'SHA256SUMS.txt');
    csvFile = fullfile(metadataDir, 'SHA256SUMS.csv');
    if exist(txtFile, 'file')
        fprintf('Converting %s to CSV format...\n', txtFile);
        fid = fopen(txtFile, 'r');
        data = textscan(fid, '%s %s', 'Delimiter', ' ');
        fclose(fid);
        T = table(data{2}, data{1}, 'VariableNames', {'Filename', 'Checksum'});
        writetable(T, csvFile);
        fprintf('Conversion complete: %s\n', csvFile);
    else
        fprintf('Warning: %s not found.\n', txtFile);
    end
end
