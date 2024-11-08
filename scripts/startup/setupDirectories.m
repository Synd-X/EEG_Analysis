function setupDirectories(rootDir, backupDir, subjectsDir, metadataDir, docsDir)
    % Create directories if they do not exist
    dirs = {rootDir, backupDir, subjectsDir, metadataDir, docsDir};
    for i = 1:length(dirs)
        if ~exist(dirs{i}, 'dir')
            mkdir(dirs{i});
            fprintf('Created directory: %s\n', dirs{i});
        end
    end
end
