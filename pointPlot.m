function pointPlot(data, ROIArray, numFish)

Radius = ROIArray(1).Radius;
boundary = Radius+10;
numFrames = length(data);

%first number is the number of frame they are on
%second number is what fish they are on
%third number is which coordinate of which frame they are on

XY = zeros(2,numFrames);

for k = 1:numFrames
   XY(1,k) = data{k}{numFish}(1);
   XY(2,k) = data{k}{numFish}(2);
    
end

for i=1:numFrames
    plot(XY(1,i),XY(2,i),'or','MarkerSize',5,'MarkerFaceColor','r')
    axis([-boundary boundary -boundary boundary])
    title(ROIArray(numFish).Label)
    pause(.01)
end


end