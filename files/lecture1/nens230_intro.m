% NENS 230 Autumn 2015 Lecture 1 Demo
% This is a script. It is viewed in the editor. 

%% Load the data and take a look  (double %% starts a new 'cell', which is a visual way to break up code)
load( 'groupA.mat' )

figure; % create a new figure
scatter( heightA, weightA ); % plot a scatter plot of heightA vs weightA
length(heightA) % how many points do we have?
min( heightA ) % what's the minimum value?

% Let's just plot the heights in order
plot( heightA )


%% Remove the outlier point

heightA(19) = []; % setting an element to [] removes it
weightA(19) = []; 

length( heightA ) % should be 19 now
length( heightA ) == length( weightA ) % let's make sure they're still the same length. 1 means true (yes)

%% Let's plot it again
scatter( heightA, weightA ); % plot a scatter plot of heightA vs weightA
% Add some labels
xlabel('Height (inches)');
ylabel('Weight (lbs)');

%% Now let's get the second group
load( 'groupBC.mat' )
length( heightB ) % we have another 20 points
length( heightC )

% Let's try plotting them all together
hold on; % keeps what's already on the plot
scatter( heightB, weightB, 'MarkerEdgeColor', 'r')
scatter( heightC, weightC, 'MarkerEdgeColor', 'g')

%% Are groups B and C likely from similar populations?
[h, p] = ttest2( heightB, heightC )
[h, p] = ttest2( weightB, weightC )

% Let's combine the adult groups and rename the kids' group
adultHeight = [heightB; heightC];
adultWeight = [weightB; weightC];
childWeight = weightA;
childHeight = heightA; 

%% Let's report some statistics:
meanChildWeight = mean( childWeight )
meanAdultWeight = mean( adultWeight )

% Are these populations' weights significantly different?
[h,p] = ttest2( childWeight, adultWeight)

% How strong is the height to weight relationship for each group?
mdlKids = fitlm( childHeight, childWeight, 'linear' ) % Very clear relationship
mdlAdults = fitlm( adultHeight, adultWeight, 'linear' ) % not nearly as strong

% Why don't we make a histogram. But this is science so let's go to kilograms
childWeight = childWeight * 0.453592;
adultWeight = adultWeight * 0.453592;

figure;
histogram( childWeight, 5 ) % second argument is number of bins
hold on;
histogram( adultWeight, 5 )
legend('Children', 'Adults')
xlabel('Weight (kgs)', 'FontSize', 16 )
ylabel('Number of People', 'FontSize', 16 )
title('Weight distributions', 'FontSize', 18)
saveas(gcf, 'weight histogram'); % gcf means 'get current figure'. We'll talk more about figure 'handles' (names) later.
