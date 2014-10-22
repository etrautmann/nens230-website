function drawPSTH( axh, binStarts, binnedSpikes)
% drawPSTH.m
%
% Takes a list of spike times for multiple trials and plots a Peristimulus-
% Time Histogram (PSTH) in the specified axis which shows the mean number of
% spikes (averaged across trials) in a given temporal bin.
%
% USAGE:
%  axh = drawPSTH( axh, spikeTimes, xlim, binTime )
%
% INPUTS:
%      axh              Axis handle where to plot the rasters
%      spikeTimes       cell array corresponding to trials, each of which contains
%                       a vector of spike times.
%      xlim             specifies the x axis limits (in same units as the
%                       spikeTimes are in (typically ms).
%                       maxExpectedBinSpike.
%      binTime          width (in same unit of time as spikeTimes are in)
%                       of the bins. Binning starts at t = xlim(1) and goes
%                       up to t = xlim(2).
%
% OUTPUTS:
%      none
%
% ==============================================================================
%
% NENS 230 - 2014  Eric Trautmann, based on code by Sergey Stavisky 2011


% Make sure the axis handle exists.
if ~ishandle( axh )
    error('You did not pass in a valid axis to drawRasters.')
end


binCenters = binStarts + (binStarts(2) - binStarts(1))/2;
bar(binCenters, binnedSpikes, 1);    % plots a bar chart

% we've hardcoded values below -> in general you want to avoid this and do it programmatically
% but we've left this simple for the time being
xlim([0 800])
ylim([0 100])
set(gca, 'xtick', [ 0 400 800])

%Don't forget to label the axes
ylabel('Time (S)')
ylabel('Average Rate (Hz) ', 'FontSize', 11)

end %function drawPSTH