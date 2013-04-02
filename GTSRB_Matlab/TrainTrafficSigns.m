function Data = TrainTrafficSigns(sBasePath)

Data = cell(43,1);
for nNumFolder = 1:43
    sFolder = num2str(nNumFolder-1, '%05d');
    
    sPath = [sBasePath, '/', sFolder, '/'];

    if isdir(sPath)
        fprintf('Loading Folder %d',nNumFolder-1);
        [Data{nNumFolder}.ImgFiles, Data{nNumFolder}.Rois, Data{nNumFolder}.Classes] = ...
            readSignData([sPath, '\GT-', num2str(nNumFolder-1, '%05d'), '.csv']);
        
        Data{nNumFolder}.Imgs = cell(numel(Data{nNumFolder}.ImgFiles),1);
        for i = 1:length(Data{nNumFolder}.Imgs);
            ImgFile = [sPath, '/', Data{nNumFolder}.ImgFiles{i}];
            Data{nNumFolder}.Imgs{i} = imread(ImgFile);
            
           % fprintf(1, 'Currently Loading: %s Class: %d Sample: %d / %d\n', ...
           %     Data{nNumFolder}.ImgFiles{i}, Data{nNumFolder}.Classes(i), i, length(Data{nNumFolder}.Imgs));
            
            % TODO!
            % if you want to work with a border around the traffic sign
            % comment the following line
            %Img = Img(Rois(i, 2) + 1:Rois(i, 4) + 1, Rois(i, 1) + 1:Rois(i, 3) + 1);

            % TODO!
            % replace this line by the function call of your training
            % function
            %MyTrainingFunction(Img, Classes(i));
                
        end
    end
        
end




function [rImgFiles, rRois, rClasses] = readSignData(aFile)
% Reads the traffic sign data.
%
% aFile         Text file that contains the data for the traffic signs
%
% rImgFiles     Cell-Array (1 x n) of Strings containing the names of the image
%               files to operate on
% rRois         (n x 4)-Array containing upper left column, upper left row,
%               lower left column, lower left row of the region of interest
%               of the traffic sign image. The image itself can have a
%               small border so this data will give you the exact bounding
%               box of the sign in the image
% rClasses      (n x 1)-Array providing the classes for each traffic sign

    fID = fopen(aFile, 'r')
    
    fgetl(fID); % discard line with column headers
    
    f = textscan(fID, '%s %*d %*d %d %d %d %d %d', 'Delimiter', ';');
    
    rImgFiles = f{1}; 
    rRois = [f{2}, f{3}, f{4}, f{5}];
    rClasses = f{6};
    
    fclose(fID);
    
    

    
   
   
function MyTrainingFunction(aImg, aClasses)

fprintf(1, 'You should replace the function MyTrainingFunction() by your own training function.\n');
