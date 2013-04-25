%% Deep Learning Data Extractino
clc;clear all;close all;

NUMBER_OF_SAMPLES = 1000000; %
PATCH_SIZE = 8;
NUMBER_OF_FILES = 599;
GRAYSCALE = 1; %Set to 3 for color
VISUALIZE = 1;

%%
addpath(genpath('.'))
Data = TSD_readGTData('TrainIJCNN2013\TrainIJCNN2013\gt.txt')
%%
PATCH_PER_IMAGE = int32(NUMBER_OF_SAMPLES / NUMBER_OF_FILES);
ATTRIBUTE_SIZE = PATCH_SIZE*PATCH_SIZE*GRAYSCALE;
PATCHES = zeros(PATCH_PER_IMAGE*NUMBER_OF_FILES,ATTRIBUTE_SIZE);
size(PATCHES)
PATCH_COUNTER = 0;
fig = figure(1);
vidObj = VideoWriter(sprintf('PatchesData_%d_%d_%d.avi',PATCH_SIZE,PATCH_SIZE,NUMBER_OF_SAMPLES));
open(vidObj);
fileno = -1;
colormap(gray(256));
for i = 1:length(Data)
    if (fileno == Data(i).fileNo)
        continue;
    end
    fileno = Data(i).fileNo;
    tic
    im = imread(sprintf('TrainIJCNN2013/TrainIJCNN2013/%.5d.ppm',fileno));
    
    if(GRAYSCALE ==1)
        im = rgb2gray(im);
    end
    
    imsize = size(im);
    if (VISUALIZE)
        
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
    if (VISUALIZE)
       rectangle('Position',[col,row,8,8],'EdgeColor',[1 0 0]);

    end
    
end
 if (VISUALIZE)
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
save(sprintf('PatchesData_%d_%d_%d.mat',PATCH_SIZE,PATCH_SIZE,NUMBER_OF_SAMPLES),'PATCHES')




