function downloadData(zipUrl, zipFileName)
    if ~exist(zipFileName, 'file')
        fprintf('Downloading data from %s...\n', zipUrl);
        websave(zipFileName, zipUrl);
        fprintf('Download complete: %s\n', zipFileName);
    else
        fprintf('Data file already exists: %s\n', zipFileName);
    end
end
