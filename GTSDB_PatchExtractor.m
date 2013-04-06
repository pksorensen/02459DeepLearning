%% Deep Learning Data Extractino
clc;clear all;close all;

NUMBER_OF_SAMPLES = 1000000; %
PATCH_SIZE = 8;
NUMBER_OF_FILES = 599;


%%
addpath(genpath('.'))
Data = TSD_readGTData('TrainIJCNN2013\TrainIJCNN2013\gt.txt')
%%
PATCH_PER_IMAGE = int32(NUMBER_OF_SAMPLES / NUMBER_OF_FILES);
ATTRIBUTE_SIZE = PATCH_SIZE*PATCH_SIZE*3;
PATCHES = zeros(PATCH_PER_IMAGE*NUMBER_OF_FILES,PATCH_SIZE*PATCH_SIZE*3);
size(PATCHES)
PATCH_COUNTER = 0;
fig = figure(1);
vidObj = VideoWriter('sample1.avi');
open(vidObj);
fileno = -1;
for i = 1:length(Data)
    if (fileno == Data(i).fileNo)
        continue;
    end
    fileno = Data(i).fileNo;
    tic
    im = imread(sprintf('TrainIJCNN2013/TrainIJCNN2013/%.5d.ppm',fileno));

    imsize = size(im);
    if (1)
        
        image(im); 
        axis image
    end
    
    NUMBER_OF_PIXELS = imsize(1)*imsize(2);   
    PIXEL_INDEXES = reshape(0:NUMBER_OF_PIXELS-1,imsize(1),imsize(2));
    PIXEL_INDEXES = PIXEL_INDEXES(1:(imsize(1)-PATCH_SIZE),1:(imsize(2)-PATCH_SIZE));
    SELECTED_PIXEL_INDEXES = PIXEL_INDEXES(randi(numel(PIXEL_INDEXES),PATCH_PER_IMAGE,1));
for n = 1:PATCH_PER_IMAGE
    PATCH_COUNTER = PATCH_COUNTER +1;
    
    col = floor(SELECTED_PIXEL_INDEXES(n) / imsize(1))+1;
    row = rem(SELECTED_PIXEL_INDEXES(n), imsize(1))+1;
    PATCHES(PATCH_COUNTER,:) = reshape(im(row:row+PATCH_SIZE-1,col:col+PATCH_SIZE-1,:),1,ATTRIBUTE_SIZE);
    if (1)
       rectangle('Position',[col,row,8,8],'EdgeColor',[1 0 0]);

    end
    
end
 if (1)
          currFrame = getframe;
       writeVideo(vidObj,currFrame);
 end
    toc
end
close(vidObj);
%a = rectangle('Position',[ Data(i).leftCol Data(i).topRow ...
%    (Data(i).bottomRow - Data(i).topRow)+1 (Data(i).rightCol - Data(i).leftCol)+1], 'EdgeColor',[1 0 0] )
% [x y w h])
%pause
%end
%%
save('PatchesData_8_8_1000000.mat','PATCHES')




