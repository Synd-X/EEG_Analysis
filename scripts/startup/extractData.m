function extractData(zipFileName, extractDir)
    fprintf('Extracting data to %s...\n', extractDir);
    unzip(zipFileName, extractDir);
    fprintf('Extraction complete.\n');
end
