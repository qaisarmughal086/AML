function createTestingMatrixs(rootFolder)
    
    keyset = {'N','A','O','~'};
    keyvalue = {0,1,2,3};
    mapobj = containers.Map(keyset,keyvalue);
   
    testingFolder = [rootFolder 'sample2017\validation\'];
    referenceFileName = [testingFolder 'REFERENCE.csv'];
    
    folder64 = [rootFolder 'spectrogram\64x64\testing_data.mat'];
    folder128 =[rootFolder 'spectrogram\128x128\testing_data.mat'];
    folder256 =[rootFolder 'spectrogram\256x256\testing_data.mat'];
    
    referenceFileData = importdata(referenceFileName);
    referenceFileData = cell2mat(referenceFileData);
    
    matFiles = dir([testingFolder '*.mat']);
    mtrx = zeros(length(matFiles),130);
    
    for windowSize = [64 128 256]  %total number of matrixs
        
        if( windowSize == 256)
            typ = zeros(4,1);
        end
        
        disp('creating training matrix for 64 windowSize');
        for matrixCount = 1:length(matFiles)  %window sizes
            [~,n,~] = fileparts(matFiles(matrixCount).name);
            disp(['opening ' n ' matrix file for extracting features using window ' num2str(windowSize)]);
            load([testingFolder matFiles(matrixCount).name]);
            [~,~,~,p] = spectrogram(val,windowSize,windowSize/2,windowSize);
            
            for featureNo = 1:size(p,1)
                mtrx(matrixCount,featureNo) = mad(p(featureNo,:),1);
            end
            ref = strsplit(referenceFileData(matrixCount,:),',');
            if(strcmp(n,char(ref(1,1))))
              mtrx(matrixCount,130)  = mapobj(char(ref(1,2)));
              
              if( windowSize == 256 )
                  if(strcmp('N',char(ref(1,2))))
                      typ(1,1) = typ(1,1) + 1;
                  end
                  if(strcmp('A',char(ref(1,2))))
                      typ(2,1) = typ(2,1) + 1;
                  end
                  if(strcmp('O',char(ref(1,2))))
                      typ(3,1) = typ(3,1) + 1;
                  end
                  if(strcmp('~',char(ref(1,2))))
                      typ(4,1) = typ(4,1) + 1;
                  end
              end
              
            else
                disp('matrix name and reference is not same');
                return
            end
        end
        
        if(windowSize == 64)
             save(folder64,'mtrx');
             disp('testing matrix for 64 window is saved');
        end
        if(windowSize == 128)
             save(folder128,'mtrx');
             disp('testing matrix for 128 window is saved');
        end
        if(windowSize == 256)
             save(folder256,'mtrx');
             disp('testing matrix for 256 window is saved');
             
             fid=fopen('output.txt','a+');
             fprintf(fid, 'Testing Data Statistics:\n');
             fprintf(fid, '%s\n',['N = ' num2str(typ(1,1))]);
             fprintf(fid, '%s\n',['A = ' num2str(typ(2,1))]);
             fprintf(fid, '%s\n',['O = ' num2str(typ(3,1))]);
             fprintf(fid, '%s\n',['~ = ' num2str(typ(4,1))]);
             fprintf(fid, '%s\n\n',['total = ' num2str(typ(1,1)+typ(2,1)+typ(3,1)+typ(4,1))]);
             fclose(fid);
        end
    end
    
end