Last Edited by: Ethan Chen, Chenghao Li, Yuxin Xu
Last Edited date: Dec 23th, 2019


This is the instruction file that explains the steps for extracting snail head positions through time.

Turning Video into Frames

1. Make sure all the .m files and your source video is in the same folder under MATLAB

If you want to crop your video frames into smaller sizes while you extract video frames from your source video, start from step 2. If there's no need of cropping, skip to step 6.

Here we are trying to first extract some sample frames and figure out  the dimension(in pixels) of the frame you desire.
2. Customize the three variables on line 10, 11 and 13
filename: name of your video including the extension. Make sure to enclose it with quotation marks.
folder: the path of the folder you wish to save your sample frames. Make sure to enclose it with quotation marks. Make sure your folder has enough space for the sample frames.
number: the number of sample frames you want to extract for figuring out dimensions. Usually 1 is enough.
If you wish to have a very big number of sampling frames, check out line 100 for further instruction.

3. Run InitialRun.m

After you click 'Run' tab, it will turn into 'Pause' tab as shown in yellow. This indicates that the program is running. Before this tab turns back into 'Run', wait gently since sometimes it could take a while for computer to do its job.
If everything goes smoothly, there should be several pop-ups on the way. The first pop up should be ''Do you want to save the individual frames out to individual disk files?''. Click yes. After a pop-up saying ''Done! blablabla", click ''Yes''. The last pop-up should be an imtool window useful for step 4.
If you see pop-ups but not the ones mentioned above, there's probably hint in the pop-ups of what went wrong.
If 'Pause' tab turns back into 'Run' before any pop-up shows up, check the command window(circled in red in picture) to see if there's any error message.

4. Figure out the dimensions


In the imtool pop-up you should be able to see the pixel index of where your cursor is at from the left bottom(colored in yellow). Using this information, you can figure out the pixel index of the upper left corner, the width and height of your desired frame.
e.g. Say, I have a video with each frame width 1920 and height 1080(pixels). I want to crop the frames so that the program only stores the rectangular area with upper left corner indexed (220,40) and lower right corner indexed (1620,1060). Thus you have the index of upper right corner(220,40). The width of your desired area is 1620-220 = 1400. The height is thus 1060-40 = 1020.

5. Make change to variable 'rect' on line 20 in ExtractMovieAVIFrames.m
rect: is a row vector containing 4 integers. Put the first integer of your upper left corner index in the first spot. Put the second integer of your upper left corner index in the second spot. The third and fourth spot are your desired width and height respectively.
e.g. rect = [220 40 1400 1020] for the example I mentioned above.

6. Make change to variables on line 13,14 and 16 in ExtractMovieAVIFrames.m
videoname: name of the video you want to extract frames from. Make sure to enclose it with quotation marks.
ratio: the percentage of frames you want extracted from the video. It should be a real number between 0 and 1.
folder: the path of the folder you wish to save your frames. Make sure to enclose it with quotation marks. Make sure your folder has enough space for the frames(since a 4GB video can easily spit out 30-50GB of frames, it would be ideal if folder is not in C drive).

7. Run ExtractMovieAVIFrames.m


After you click 'Run' tab, it will turn into 'Pause' tab as shown in yellow. This indicates that the program is running. Before this tab turns back into 'Run', wait gently since sometimes it could take a while for the pop-ups to come.
If everything goes smoothly, there should be several pop-ups on the way. The first pop up should be ''Do you want to save the individual frames out to individual disk files?''. Click yes. Then there should be another pop-up displaying each frame your computer is storing with their index and the total number of frames in the video. You can also see the progress in the command window(circled in red). After a long time of furious work, there will be a pop-up saying ''Done! blablabla", click ''Yes'' and you have all your frames!
If you see pop-ups but not the ones mentioned above, there's probably hint in the pop-ups of what went wrong.
If 'Pause' tab turns back into 'Run' before any pop-up shows up, check the command window(circled in red in picture) to see if there's any error message.

8. Extracting the data

To extract data, this is separated into three steps:
	1. Manually Placing the Region of Interest (ROI)
	2. Extracting the Data
	3. Displaying the Data

For the first step, you will need to edit the 'frameScript.m' file and change a number of values. First there will be a line that says:

cd = 'C:\...'

You will have to change this to the directory/folder address where your have stored the pictures inside the '...'. From there you have to determine a couple of parameters for the ROIs. Since the ROIs were not able to identify how many tubes there are within an image, and if that tube has a fish in the first place, you have to manually input the number of fish, the number of control fish, the number of protein injected fish, and the number of venom fish by changing the numFish, numControl, numProtein and numVenom values respectively.
 Since the labels being limitied to these three catagories was more important to our project, you may have to rename some of the labels, regardless, the fish themselves will be numbered and isolated. You can actually just separate them in three catagories you see fit, if you would like to see more catagories, that would be feasible. and extracting infomation is still possible.
The radius of the circles are also adjustible as you can change the number after 'Radius' in the circle command, you can adjust these however you like, but the noise will increase if it is too big.
After you have changed these values a figure from matlab will appear with the ROIs in the top left corner. Just click and drag them over each tube with their respective label.

For the second step you need to edit the 'getData.m' file where you have to change the directory again by editing the line:

cd = 'C:\...'

the same way you did before.

After that, there is some customization available. You can change the ratio of number of frames to keep. Its currently set at 'ratio = 6', that means that one out of every 6 frames will be kept. The benefit of increasing this number is that the runtime will improve, as well as the difference between each data point will more apparent, so you decide how you want to adjust that number.

All you have to do now is run the command:

[data, labels] =  getData(ROIArray , imagefiles);

	This will result in data being stored in an array of coordinates.

	The third step will takes the data and convert it into a moving plot that will make it easier to analyze. All you need to do is to run the command:

 pointPlot(data, ROIArray, numFish)

	where numFish is the which fish you wish to analyze with the number you input corresponds with which fish.

	There are some manual tweeking you can do, but its mostly unnecessary, you can change the title, of the plot, or adjust how much time between each point being displayed. Either way, you get a visualization of the data.




If you have any questions about matlab, how the code works, or any issues with the code, do not hesitate to email us any questions, thank you!
