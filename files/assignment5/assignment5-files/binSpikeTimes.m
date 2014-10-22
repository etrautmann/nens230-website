function [binnedSpikeCount, binStarts] = binSpikeTimes( spikeTimes, binSize, startTime, endTime )
% binSpikeTimes.m
%
% Takes a list of spike times for one or more channels, from one or more
% trials, and returns a matrix of binned spike counts for each channel, summed
% across trials.
% NOTE: This function does not enforce units (e.g. ms or seconds) so it is
% up to the caller to verify that all arguments are in the same unit.
% NOTE 2: if (endT-startT) does not divide evenly by binT, then the last bin
% will be cut off (i.e. shorter than binT).
%
% USAGE:
%  binnedSpikeCount = binSpikeTimes( spikeTimes, binT, startT, endT )
%
% INPUTS:
%      spikeTimes    cell array containing vectors of spike times.
%                    Should be trials x chans
%      binSize          time width of the bins in ms.
%      startTime        start time of first bin in ms.
%      endTime          end time of last bin in ms
% OUTPUTS:
%      binnedSpikeCount     bin x chan matrix containing the number of spikes
%                    (averaged over trials) for a given channel and time bin.
%      binStarts     start time of each bin
%
% =============================================
%
% NENS fall 2014



% create two variables, numElectrodes and numTrials using your input
% arguement spikeTimes. numElectrodes should store the number of electrodes,
% numTrials should store the number of trials. Hint: You can get this info from
% the size of the spikeTimes cell array using the size() function

numTrials = 
numChannels =



numBins=(endTime-startTime)/binSize;  % the number of bins in a trial given the bin size and start and stop times

% We now define bin start and end times.
binStarts = linspace(startTime, endTime-binSize, numBins);
binEnds = linspace(startTime+binSize, endTime, numBins);



% Preallocate output array binnedSpikeCount.  This is for efficienty, we'll talk
% more about preallocating arrays soon.
binnedSpikeCount = zeros( numBins, numChannels);


% Loop across all time bins and add up the spikes that fall within this
% bin. There are many ways to do this, use whatever you can think of!
% This is the meat of this function
%
%
% You'll want three "nested" loops to count all of the spikes that fall in each bin.
% In the outermost loop, you'll want to loop across time Bin
% the next loop in, you'll want to loop over electrodes
% Finally, in the inner most loop, you'll want to loop over all of the trials
%
% The code should resemble the following pseudocode:
%
% loop timebib=n
%    thisBinStartTime = binStarts( time bin loop variable) 
%    thisBinStopTime = ...
%     
%    loop over channels
%    	set spikeCount to zero
%       loop over trials
%           add spikes that fall after start time and before stop time to the spikeCount
%       end
%       store spikeCount in the correct place in binnedSpikeCount(bin loop variable, channel loop variable)
%    end
% end
%


% Finally, divide  binnedSpikeCount by number of trials to get average number of spikes/bin/trial
binnedSpikeCount=binnedSpikeCount./numTrials;