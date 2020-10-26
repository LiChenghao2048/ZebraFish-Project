% extract a few frames, save them in a file and measure the size (in pixels)
% of the frame that you want to crop out
clc;    % Clear the command window.
close all;  % Close all figures (except those of imtool.)
imtool close all;  % Close all imtool figures.
clear;  % Erase all existing variables.
workspace;  % Make sure the workspace panel is showing.
fontSize = 14;

filename = 'CIMG6908.MOV'; % put the name of your video here!
folder = "D:\Academics\Comp 347\frames1"; % put the path of where you want 
% to save the video frame you extract
number = 1; % put the number of frames you want to save to figure out the 
% dimension of frame you want to crop out. Normally 1 is enough.
% if number is not an integer, print a line for warning.
if ~isinteger(number)
    display('line 13 is not integer')
end


% Change the current folder to the folder of this m-file.
% (The line of code below is from Brett Shoelson of The Mathworks.)
if(~isdeployed)
	cd(fileparts(which(mfilename)));
end

% Open the the video we hope to process.
movieFullFileName = fullfile(filename);
% Check to see that it exists.
if ~exist(movieFullFileName, 'file')
	strErrorMessage = sprintf('File not found:\n%s\nYou can choose a new one, or cancel', movieFullFileName);
	response = questdlg(strErrorMessage, 'File not found', 'OK - choose a new movie.', 'Cancel', 'OK - choose a new movie.');
	if strcmpi(response, 'OK - choose a new movie.')
		[baseFileName, folderName, FilterIndex] = uigetfile('*.avi');
		if ~isequal(baseFileName, 0)
			movieFullFileName = fullfile(folderName, baseFileName);
		else
			return;
		end
	else
		return;
	end
end

try
	videoObject = VideoReader(movieFullFileName)
	% Determine how many frames there are.
	numberOfFrames = videoObject.NumberOfFrames;
    % here we want to extract min(numberOfFrames, number)
    numExtract = min(numberOfFrames, number);
	numberOfFramesWritten = 0;
	% Prepare a figure to show the images in the upper half of the screen.
	figure;
	% 	screenSize = get(0, 'ScreenSize');
	% Enlarge figure to full screen.
	set(gcf, 'units','normalized','outerposition',[0 0 1 1]);
	
	% Ask user if they want to write the individual frames out to disk.
	promptMessage = sprintf('Do you want to save the individual frames out to individual disk files?');
	button = questdlg(promptMessage, 'Save individual frames?', 'Yes', 'No', 'Yes');
	if strcmp(button, 'Yes')
		writeToDisk = true;
		% Extract out the various parts of the filename.
		[~, baseFileName, extentions] = fileparts(movieFullFileName);
		% Make up a special new output subfolder for all the separate
		% movie frames that we're going to extract and save to disk.
		% (Don't worry - windows can handle forward slashes in the folder name.)
		folder = pwd;   % Make it a subfolder of the folder where this m-file lives.
		outputFolder = sprintf('%s/Movie Frames from %s', folder, baseFileName);
		% Create the folder if it doesn't exist already.If it does exist,
		% delete it and create a new empty one.
		if ~exist(outputFolder, 'dir')
			mkdir(outputFolder);
        else
            rmdir(outputFolder,'s')
            mkdir(outputFolder);
		end
	else
		writeToDisk = false;
	end
	
	% Loop through the movie, writing all frames out.
	% Each frame will be in a separate file with unique name.
	for frame = 1 : numExtract
		% Extract the frame from the movie structure.
		thisFrame = read(videoObject, frame);
        
		% Display it
		hImage = subplot(2, 2, 1);
		image(thisFrame);
		caption = sprintf('Frame %4d of %d.', frame, numberOfFrames);
		title(caption, 'FontSize', fontSize);
		drawnow; % Force it to refresh the window.
		
		% Write the image array to the output file, if requested.
		if writeToDisk
			% Construct an output image file name.
            % the two 6 here indicates the number of places of index 
            % you want to have. 
            % Make sure the number of video frames is
            % less than six figures. If not, adjust both of the numbers
            % into the actual number of figures. i.e.
            % if number in line 13 is 1000000, which is a 7 figure number,
            % outputBaseFileName = sprintf('%7.7d.png', frame);
            % make sure you change the index in line 142 accordingly
			outputBaseFileName = sprintf('%6.6d.png', frame);
			outputFullFileName = fullfile(outputFolder, outputBaseFileName);
			imwrite(thisFrame, outputFullFileName, 'png');
		end
		
		% Update user with the progress.  Display in the command window.
		if writeToDisk
			progressIndication = sprintf('Wrote frame %4d of %d.', frame, numberOfFrames);
		else
			progressIndication = sprintf('Processed frame %4d of %d.', frame, numberOfFrames);
		end
		disp(progressIndication);
		% Increment frame count (should eventually = numberOfFrames
		% unless an error happens).
		numberOfFramesWritten = numberOfFramesWritten + 1;
	end
	
	% Alert user that we're done.
	if writeToDisk
		finishedMessage = sprintf('Done!  It wrote %d frames to folder\n"%s"', numberOfFramesWritten, outputFolder);
	else
		finishedMessage = sprintf('Done!  It processed %d frames of\n"%s"', numberOfFramesWritten, movieFullFileName);
	end
	disp(finishedMessage); % Write to command window.
	uiwait(msgbox(finishedMessage)); % Also pop up a message box.
	
	% Exit if they didn't write any individual frames out to disk.
	if ~writeToDisk
		return;
    end
catch ME
	% Some error happened if you get here.
	strErrorMessage = sprintf('Error extracting movie frames from:\n\n%s\n\nError: %s\n\n)', movieFullFileName, ME.message);
	uiwait(msgbox(strErrorMessage));
end

% read the first picture into matlab
A = imread(strcat(folder,"\Movie Frames from ",baseFileName,"\000001.png"));

% use image tools(there should be a pop up window) to pinpoint the indices
% of pixels we want to cut off from our picture frames
%imtool(A)
A = A(:,:,1);
imtool(A)