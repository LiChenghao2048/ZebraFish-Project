%
%make sure this leads to the folder where the movie frames are
%
% this is an example
cd 'C:\Users\Ethan Chen\Desktop\Data\Movie Frames From 6908\Movie Frames from CIMG6908';

imagefiles = dir('*.png');    

I = imread(imagefiles(1).name);
I = I(:,:,1);

% Please Change the numbers here to the frame accordingly
%
%
%
%
%
numFish = 25; %number of fish
numControl = 3; %number of Control Fish
numVenom = 12; %number of Venom Fish
numProtein = 10; %number of Protein Fish
%
%
%
%
%
%


figure;
imshow(I);

for i = 1 : numFish
    %
    %Change the number after 'Radius' to change the radius of the Circles
    %in the image
    %
    h = images.roi.Circle(gca,'Center', [100 100] ,'Radius', 80);
    %
    %
    %
    disp(h);
    addlistener(h,'MovingROI',@allevents);
    addlistener(h,'ROIMoved',@allevents);
    
    if i > numFish-numControl %change this
        h.Label = "Control";
    elseif i > numProtein && i <= numFish-numControl
        h.Label = "Venom";
    else
        h.Label = "Protein";
    end
    ROIArray(i) = h;
end


% Run this after you finish placing the ROIs
%[data, labels] =  getData(ROIArray , imagefiles);
