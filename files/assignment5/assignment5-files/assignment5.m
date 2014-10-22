% NENS 230 Autumn 2014, Stanford University
% Assignment 5


%% Load data

% Rember to make sure that this folder is on your matlab path.  
% You can add it to the path using pathtool, or by navigating to the folder and right
% clicking -> add to path -> Selected folder and subfolders.

% Run just the code in this cell with command-enter (mac, linux) or ctrl-enter (win), 
% or by clicking Run Section in the editor tab

filename = 'J20110809_M1.mat';


try % The try syntax tries to run a line, and if it fails, runs the catch block
    load( filename )
catch
    error('Could not load %s, check filename', filename )
end



%% Add some parameters to the workspace

% Select which electrode you want to look at.  Play around with this if you want, 
% but submit the results with Channel = 16;
Channel = 16;

numDirs = length(reachingData); % number of different reach directions.

% These parameters are passed to the plotting functions for each direction,
% and help ensure uniformity across all of them.

% In this data set, different trials are of different lengths, but all are at
% least 800ms long. The analysis is simpler if we don't worry about the
% post-800ms epoch, for which there may be data from some trials but not others.

params.binSize = 50;
params.startTime = 0;
params.endTime = 800;

% You want to create a lookup table of which subplot each direction of reaches should be
% plotted in. Try loading the data and see the reachingData.targetDir
% field to see which elemement of the structure corresponds to which
% direction's reaches. Then change the numbers in the array based on which subplot index
% that direction should go in (e.g. the upward ('N'orth) reach trials
% should be plotted in the subplot index which corresponds to the
% top-center subplot axis, in this case 2. Remember that subplot numbers them from
% top left to bottom right, as if you were reading a page (the technical
% term for this is 'rasterwise'.).  If we have a 3x3 array of subplots, then the numbering looks like:
%
%   1 2 3
%   4 5 6
%   7 8 9
%
% This order is incorrect; reorder it correctly!
subplotIndices = [ 1 2 3 4 5 6 7 8]; 



%% Create the figure

% Create a figure. You can keep track of the figure by creating a figure handle as
% the optional output argument for the figure() function. type >> doc figure     for help

% [ YOUR CODE HERE ]



% Let's make this figure kind of large so it's easy to see the subplots as they are added in.
% Note that you can always resize it later. To do this, set the 'Position' property of your
% figure to be [screenXposition screenYPosition width height]. The screen position doesn't
% really matter as long as it's visible. [1 1 1000 1000] would make the figure 1000x1000 pixels
% and place it at the top-left of your screen. Note that on some linux machines this command
% doesn't work for some reason; you'll have to just accept default size and manually drag-resize
% the figure to suit you.  Use the set(.....) function and the keyword gcf (get current figure)

% [ YOUR CODE HERE ]




%%  Now add code to the binSpikeTimes.m function to make it return a matrix of binned spike counts
% there's lots of hints and pseudocode in the incomplete function already. 

% this cell is just for testing and debugging the function.  

% pull the spike times from the first reach direction for testing and developing your function
spikes = reachingData(1).spikeTimes;

% then call your function here
[binnedMat, binStarts] = binSpikeTimes( spikes, params.binSize, params.startTime, params.endTime );




%% Loop across the eight directions and create the subplot for each

% This will be the meat of the figure making. It loops through the
% eight different directions, each of which are one struct in the struct array

for iDir = 1 : numDirs
    % Pull out the spike time data for this direction and put it in a variable called 
    % theseSpikeTimes
    
    % [ YOUR CODE HERE ]  

    
    
    % -----------------------------------------------------------
    %                   CREATE THE SUBPLOT.
    % -----------------------------------------------------------
    % Recall that we want a 3x3 grid, and that each direction gets
    % plotted into one of the eight noncenter subplots.
    
    thisSubplotInd = subplotIndices(iDir); % use this for the third
    % argument into subplot function to correctly choose at which location
    % this direction's plot should be created.
    
    % call subplot with the correct index that you just selected.  The (optional) output of 
    % subplot will give you an axis handle.  Store that in a variable called thisAxis
    % This will be the handle of the axis you've just created; you can pass this
    % and the requisite data into the specific raster, histogram, and region of interest
    % functions.
    
    
    % [ YOUR CODE HERE ]

    
    
    
    
    % -----------------------------------------------------------
    %                      Bin Spikes 
    % -----------------------------------------------------------
    % Call your binSpikeTimes function for the set of spike times corresponding to 
    % this reach direction
    
    % [ YOUR CODE HERE ]
    
    
    
    % Extract just the spike times from the channel that we're interested.  
    % This corresponds to pulling the correct column out of the matrix
    % call your variable 'selectedChannelSpikes'
    
    % [ YOUR CODE HERE ]
    
    
    % now convert the spike count into a spike rate -> nothing you need to do here
    thisChannelRate = selectedChannelSpikes * 1000/params.binSize;
    
    
    
    % -----------------------------------------------------------
    %                       PSTH PLOT
    % -----------------------------------------------------------
    % we now want to draw the PSTH into the correct axis.  We've written this function
    % for you already, but take a look at how we're passing the axis handle in as the first parameter 
    % so the function knows where to plot the data
    drawPSTH( thisAxis, binStarts, thisChannelRate);
    

end 


