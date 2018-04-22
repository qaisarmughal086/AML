function deleteCommonFiles(rootFolder)

    trainingDataFolder = [rootFolder 'training2017\'];
    testingFolder = [rootFolder 'sample2017\validation\'];
    
    matFiles = dir([testingFolder '*.mat']);
    
     
    for matrixCount = 1:length(matFiles)
        delete([trainingDataFolder matFiles(matrixCount).name]);
        disp(['file ' matFiles(matrixCount).name ' is deleted']);
    end
    
    fid=fopen('output.txt','wt');
    fprintf(fid, '%i Files deleted from %s\n\n',length(matFiles),trainingDataFolder);
    fclose(fid);
    
end