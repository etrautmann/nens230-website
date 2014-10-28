%% NENS 230: Starter code for Assignment 3

%% Part 1: FRET analysis with single molecule data

%% 1.a Load the single molecule imaging data
load('singlemolecule')

%% 1.b Plot raw fluorescence traces over time.
figure(1);

%% 1.c Compute single-image FRET ratio
% FRET = ...

% Plot the single-image FRET ratio
figure(2);
% plot(....)

%% 1.d Find a reasonable value from the above plot, and threshold the data
% loopedDNA = ...

%% 1.e Compute the probability of a DNA segment being in the "looped" state
%pLooped = ...


%% 1.f Compute rate of looping (kl) and unlooping (ku)
% kl = number of L->H FRET transitions divided by low time
% ku = number of H->L FRET transitions divided by high time

% Preallocate transition-counting variables
lowToHigh = 0;
highToLow = 0;

% Loop over time points to determine if there is a low-to-high or high-to-low transition
for i = 1:?
	% Use if/else logic to determine the type of each transition
end

% Calculate kl (rate of looping) and ku (rate of unlooping)
%kl = ...
%ku = ...

%% 1.g Calculate the time constant for looping
% tau = ...

% Display results in a reasonably informative format
%fprintf(...)
%fprintf(...)

%% Part 2: FRET analysis with population imaging data

%% 2.a Compute the FRET ratio for an entire image

% Time points corresponding to each of the 8 images.
It = [0 1 4 11 18 28 40 75];

% Loop over each image
for i = 1:8

    % 2.b Load the image
	% imread(...)

    % 2.c Convert the image to double format
	% double(...)

    % 2.d Extract the donor channel (g) and the acceptor channel (r) from the full image
	% Use :-indexing!

    % 2.e Calculate the FRET ratio the entire current image. You use either 'sum' or
	% 'mean', but you have to end up with a single value for each image.
    % FRET = ...

end

% Plot the results, the FRET ratio at each of the time points in It
figure(3);
plot(It, ...)

% Plot the steady-state value for the fraction of looped DNA
hold on;
plot([0 75], ...)
