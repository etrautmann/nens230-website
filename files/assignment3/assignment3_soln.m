% NENS 230: Assignment #3 Solution
% Benjamin Naecker bnaecker@stanford.edu
% Niru Maheshwaranathan nirum@stanford.edu

%% Clean up the previous workspace and add the needed files to the path
clear;
close all;
addpath('assignment3-materials');

%% Part 1: FRET analysis with single molecule data

% 1.a Load the single molecule imaging data
load('singlemolecule.mat');

% 1.b Plot the raw fluorescence intensity from the 
% single-molecule data over time
figure(1);
plot(t, Fd, 'g', t, Fa,'r');
ylabel('Fluorescence intensity');
legend('Donor', 'Acceptor');

% 1.c Compute the FRET ratio of the single molecule trace
FRET = Fa ./ (Fa + Fd);

% Plot this ratio FRET ratio over time
figure(2);
plot(t, FRET, 'k');
xlabel('Times (s)');
ylabel('FRET ratio');
ylim([-.1 1])

% 1.d Pick a reasonable threshold, and use a relational operator
% to find the time points at which the FRET ratio is above this.
loopedDNA = FRET > .5;

% 1.e Calculate the probability of the DNA being looped
pLooped = sum(loopedDNA) / length(loopedDNA);
% NOTE: It also works to do:
% pLooped = mean(loopedDNA);
fprintf('The probability of DNA being looped is %0.4f\n\n', pLooped);

% 1.f Calculate the rate of looping (kl) and unlooping (ku)
% kl = number of L->H FRET transitions/low time
% ku = number of H->L FRET transitions/high time

% Initialized counters for the number of transitisions of each type
lowToHigh = 0;
highToLow = 0;

% Loop over time points, and use if/else logic to determine the type
% of transition, if any
for ti = 1 : (length(loopedDNA) - 1)
    if (~loopedDNA(ti) && loopedDNA(ti + 1))
        lowToHigh = lowToHigh + 1;
    elseif (loopedDNA(ti) && ~loopedDNA(ti + 1))
        highToLow = highToLow + 1;
    end
end

% BONUS: Vectorized method for low-to-high and high-to-low transitions
% transitions = diff(loopedDNA);
% lowToHigh = sum(transitions > 0);
% highToLow = sum(transitions < 0);

% Calculate kl (rate of looping) and ku (rate of unlooping)
kl = lowToHigh / sum(~loopedDNA);
ku = highToLow / sum(loopedDNA);

% 1.g Calculate the time constant for looping: tau = 1/(kl + ku)
tau = 1 / (kl + ku);

% Calculate the steady-state looped fraction: C = kl/(kl+ku)
C = kl / (kl + ku);

% Print results to the screen
fprintf('kL\t=\t%0.5f Hz\t(rate of looping)\n', kl);
fprintf('kU\t=\t%0.5f Hz\t(rate of unlooping)\n', ku);
fprintf('tau\t=\t%0.3f sec\t(time constant)\n', tau)

%% Part 2: FRET analysis with population imaging data

% 2.a Take the FRET ratio of a time lapse image
% Data provided as images at 8 time points
It = [0 1 4 11 18 28 40 75];
nimages = length(It);

% Pre-allocate array to hold FRET ratios for each image
fracLooped = zeros(nimages, 1);

% Calculate ratios for each image
for i = 1:nimages

    % 2.b Load the image
    filename = sprintf('./assignment3-materials/img%d.tif', i);
    currImage = imread(filename);

    % 2.c Convert the image to a double to avoid rounding error with uint8
    currImage = double(currImage);

    % 2.d Extract the donor channel (g) and the acceptor channel (r)
    Ia = currImage(:, :, 1);
    Id = currImage(:, :, 2);

    % 2.e Calculate the FRET ratio for the whole image, by first summing
	% *all* of the red/green channels, then computing the ratio.
	fracLooped(i) = sum(Ia(:)) ./ (sum(Ia(:)) + sum(Id(:)));

	% NOTE: You can also use the 'mean' function to compute the FRET ratio,
	% but in this case, you need to make sure you aren't dividing by 0
	% (image pixels where there is no signal at all). We can use the shortcut
	% function 'nanmean', which computes the mean ignoring all NaNs.
	%FRET = Ia ./ (Ia + Id);
	%fracLooped(i) = nanmean(FRET(:));

end

% Plot the fraction looped results
figure(3); clf
plot(It, fracLooped, '-ok');
xlabel('Time (s)');
ylabel('Looped fraction');
hold on;
plot([0 80], [C C], 'r')
