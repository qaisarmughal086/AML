function  matToArff(fileName)
     
        
        [p,n,e] = fileparts(fileName);
        disp(['opening mat file ' fileName]);
        a = load(fileName);
        featureMatrix = a.mtrx;

        arffFileName = [p '\' n '.arff'];
        
        if (~(exist(arffFileName,'file') == 2))
            disp(strcat('creating , ',char(arffFileName),' file.....'));
            fid = fopen(arffFileName, 'a+'); 
            disp('generating header information...');
            fprintf(fid, '@relation %s \n\n', fileName);
            % create ATTRIBUTE entry for each variable
            totalAttrib = size(featureMatrix,2) - 1 ;
                for x=1:totalAttrib
                    fprintf(fid, '@attribute %s numeric\n', ['attrib' num2str(x)]);
                end

            fprintf(fid, '@attribute class {%s} \n\n', '0,1,2,3');
            fprintf(fid, '@data \n');
            disp('header information written succesfully');
            disp('writing feature data from mat-file...');
        else
            disp(strcat(char(fileName),'.arff ,',' file already exists.....'));
            disp('opening arff file...');
            fid = fopen(arffFileName, 'a+'); 
            fread(fid);
            disp('appending feature data from mat-file...');
        end
            % append dataset for each fature-set
            totalRows = size(featureMatrix,1);
            totalColumns = size(featureMatrix,2);
                for r=1:totalRows 
                    for c=1:totalColumns
                        if(c < totalColumns)
                            if(isnan(featureMatrix(r,c)))
                                sum = 0;
                                for i=1:totalColumns-1
                                    sum = sum+featureMatrix(r,i);
                                end
                                fprintf(fid, '%f,',sum/(totalColumns-1));
                            else
                                fprintf(fid, '%f,', featureMatrix(r,c));
                            end
                        else
                            fprintf(fid, '%i\n', featureMatrix(r,c));
                        end
                    end
                end
            disp('data block added to arff file succesfully....');
            fclose(fid);
            clc;
end
