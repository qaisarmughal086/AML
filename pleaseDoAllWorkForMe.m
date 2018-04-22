function pleaseDoAllWorkForMe()

    rootFolder = 'E:\Uol\4th\aml\research\';
    
    deleteCommonFiles(rootFolder);
    createTrainingMatrixs(rootFolder);
    createTestingMatrixs(rootFolder)
    
    folder64 = [rootFolder 'spectrogram\64x64\training_data.mat'];
    matToArff(folder64);
    folder128 =[rootFolder 'spectrogram\128x128\training_data.mat'];
    matToArff(folder128);
    folder256 =[rootFolder 'spectrogram\256x256\training_data.mat'];
    matToArff(folder256);
    
    folder64 = [rootFolder 'spectrogram\64x64\testing_data.mat'];
    matToArff(folder64);
    folder128 =[rootFolder 'spectrogram\128x128\testing_data.mat'];
    matToArff(folder128);
    folder256 =[rootFolder 'spectrogram\256x256\testing_data.mat'];
    matToArff(folder256);
end