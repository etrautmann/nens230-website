%% Niru Maheswaranathan
%  October 14, 2012
%  Making Pretty Graphs
%  (Adapted from http://blogs.mathworks.com/loren/2007/12/11/making-pretty-graphs/)

%% Load Data
load data

%% Create Basic Plot
% First, plot the data to create the crude visualization.
% Notice how we are storing the handles as variables!
figure(1); clf;     % this command brings up a figure and clears it (wipes it clean)
hold on;            % this is so we can plot multiple things on top of one another

hFit   = line(xfit  , yfit   );                 % fitted data
hE     = errorbar(xdata_m, ydata_m, ydata_s);   % error bar plot
hData  = line(xVdata, yVdata );                 % more data
hModel = line(xmodel, ymodel );                 % fitted line
hCI(1) = line(xmodel, ymodelL);                 % lower confidence interval
hCI(2) = line(xmodel, ymodelU);                 % upper confidence interval
print -depsc2 finalPlot0.eps
waitforbuttonpress;

%% Adjust Line Properties
% Here, we change the color and style of the lines
set(hFit, 'Color', [0 0 .5]);
set(hE, 'LineStyle', 'none', 'Marker', '.', 'Color', [.3 .3 .3]);
set(hData, 'LineStyle', 'none', 'Marker', '.');
set(hModel, 'LineStyle', '--', 'Color', 'r');
set(hCI(1), 'LineStyle', '-.', 'Color', [0 .5 0]);
set(hCI(2), 'LineStyle', '-.', 'Color', [0 .5 0]);

% Here, we change other properties: thickness of the lines, and size/color of the markers
set(hFit, 'LineWidth', 2);
set(hE, 'LineWidth', 1, 'Marker', 'o', 'MarkerSize', 6, 'MarkerEdgeColor', [.2 .2 .2], 'MarkerFaceColor', [.7 .7 .7]);
set(hData, 'Marker', 'o', 'MarkerSize', 5, 'MarkerEdgeColor', 'none', 'MarkerFaceColor', [.75 .75 1]);
set(hModel, 'LineWidth', 1.5);
set(hCI(1), 'LineWidth', 1.5);
set(hCI(2), 'LineWidth', 1.5);

% And finally, we edit the errorbar
hE_c = get(hE, 'Children');
errorbarXData = get(hE_c(2), 'XData');
errorbarXData(4:9:end) = errorbarXData(1:9:end) - 0.2;
errorbarXData(7:9:end) = errorbarXData(1:9:end) - 0.2;
errorbarXData(5:9:end) = errorbarXData(1:9:end) + 0.2;
errorbarXData(8:9:end) = errorbarXData(1:9:end) + 0.2;
set(hE_c(2), 'XData', errorbarXData);

%% Add Legend and Labels
% No plot is complete unless it is well annotated!
% Again, note how we store the handles to the labels
hTitle  = title ('My Publication-Quality Graphics');
hXLabel = xlabel('Length (m)');
hYLabel = ylabel('Mass (kg)');

% Let's put a label in the middle of the figure using the 'text' function
hText   = text(10, 800, sprintf('\\it{C = %0.1g \\pm %0.1g (CI)}', c, cint(2)-c));

% And add a legend
hLegend = legend([hE, hFit, hData, hModel, hCI(1)], 'Data (\mu \pm \sigma)', 'Fit (\it{C x^3})', 'Validation Data', 'Model (\it{C x^3})', '95% CI', 'location', 'NorthWest');

%% Adjust Font and Axes Properties
set(gca, 'FontName', 'Helvetica');
set([hTitle, hXLabel, hYLabel, hText], 'FontName', 'AvantGarde');
set([hLegend, gca], 'FontSize', 8);
set([hXLabel, hYLabel, hText], 'FontSize', 10);
set( hTitle, 'FontSize', 12, 'FontWeight', 'bold');

% set some properties for the whole figure
set(gca, ...
  'Box'         , 'off'     , ...
  'TickDir'     , 'out'     , ...
  'TickLength'  , [.02 .02] , ...
  'XMinorTick'  , 'on'      , ...
  'YMinorTick'  , 'on'      , ...
  'YGrid'       , 'on'      , ...
  'XColor'      , [.3 .3 .3], ...
  'YColor'      , [.3 .3 .3], ...
  'YTick'       , 0:500:2500, ...
  'LineWidth'   , 1         );

%% Export to EPS
% Set |PaperPositionMode| to auto so that the exported figure looks like
% it does on the screen.
set(gcf, 'PaperPositionMode', 'auto');
print -depsc2 finalPlot1.eps

% Postprocess: We use the following function to make the lines a bit more visible:
fixPSlinestyle('finalPlot1.eps', 'finalPlot2.eps');
