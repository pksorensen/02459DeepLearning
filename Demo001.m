%% DEEP LEARNING

clc;
clear all;
close all;
addpath(genpath('.'));
%%

Data = TrainTrafficSigns('GTSRB_Final_Training_Images/GTSRB/Final_Training/Images');
save('Data.mat','Data');
%%
clear all
load('Data.mat');
%%
figure(1)
M = 16;
overlap = 2;
classes = zeros(length(Data),1);
patches = zeros(length(Data),1);
for n=1:length(Data)
   %classes(n) = length(Data{n}.Classes) ;
   for m = 1:length(Data{n}.Imgs)
       s = size(Data{n}.Imgs{m});
       patches(n) = patches(n) + (min(s(1),s(2)) / (M/overlap))^2;
       classes(n) = length(Data{n}.Imgs);
   end       
end
bar(classes)
N = floor(min(patches)) %How many patches per Class.
N*42

%%
impatches = zeros(N*42,M*M*3);
labels = zeros(N*42,1);
pn = 1;
for n=1:length(Data)
   %classes(n) = length(Data{n}.Classes) ;
   n
   for m = 1:length(Data{n}.Imgs)
       s = size(Data{n}.Imgs{m});
       n_patches = round((min(s(1),s(2)) / (M/overlap)));
       pn:pn+n_patches-1;
       impatches(pn:pn+n_patches-1, :) = getImBlocks(Data{n}.Imgs{m},M,n_patches)';
       labels(pn:pn+n_patches-1) = n-1;
       pn = pn + n_patches;
   end       
end

%% FULL IMAGES
addpath(genpath('.'))
Data = TSD_readGTData('TrainIJCNN2013\TrainIJCNN2013\gt.txt')
for i = randperm(length(Data))
imshow(sprintf('TrainIJCNN2013/TrainIJCNN2013/%.5d.ppm',Data(i).fileNo))
a = rectangle('Position',[ Data(i).leftCol Data(i).topRow ...
    (Data(i).bottomRow - Data(i).topRow)+1 (Data(i).rightCol - Data(i).leftCol)+1], 'EdgeColor',[1 0 0] )% [x y w h])
pause
end
