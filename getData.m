function [data, labels] = getData(ROIArray, fold)

%change the cd to the folder that contains the movie frames

cd 'C:\Users\Ethan Chen\Desktop\Data\Movie Frames From 6908\Movie Frames from CIMG6908';

ratio = 6;
labels = ones(22,1);

for i = 1:length(ROIArray)
    if strcmp(ROIArray(i).Label, 'Control')
     labels(i) = 1;
    elseif strcmp(ROIArray(i).Label, 'Protein')
     labels(i) = 2;
    elseif strcmp(ROIArray(i).Label, 'Venom')
     labels(i) = 3;
    end
end

numImage = length(fold);
imagePicked = cell(floor(numImage/ratio), 1);


for i = ratio:ratio:numImage
         imagePicked{i/ratio,1} = fold(i).name;
end

%{


This commented out section was purely for a specific case where not all the
frames were filtered


for i = ratio:ratio:46099
    %just because the data was weird 
         imagePicked{i/ratio,1} = fold(i).name;
end
index = length(imagePicked) + 1;
for i = 46099:numImage
    imagePicked{index, 1} = fold(i).name;
    index = index + 1;
end

%}


data = cell(1, length(imagePicked));

for i=1:length(imagePicked)
   currentimage = imread(imagePicked{i});
   heads = HeadFinder(currentimage, ROIArray);
   data{1,i} = heads;
end

%
%
%to display the data use this command where numFish the specific fish you wish to analyse:
%pointPlot(data, ROIArray, numFish)


end

