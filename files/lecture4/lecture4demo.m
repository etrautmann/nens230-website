% Lecture 4 demos

% Eric Trautmann
%    10/12/2015  
% incorporating original version from 
% Niru Maheswaranathan
%  October 14, 2012
%  Making Pretty Graphs
%  (Adapted from http://blogs.mathworks.com/loren/2007/12/11/making-pretty-graphs/)


%% example showing switching figures and then reselecting a previous figure

% plot one figure
figHandle = figure(1); 
clf;
plot(rand(10,3))

% create a new figure and then plot
figure(2); clf;
plot(rand(10,1))

% reselect first figure again
figure(figHandle)


%%  Basic line plot
figHandle = figure(1); clf;
nPts = 12;
xdata = linspace(0,1,nPts);
ydata = rand(nPts,3);
plot(xdata, ydata);


%% Histogram

figure(2); clf;

data1 = randn(1,10000);
data2 = 1+randn(1,10000);
nBins = 10;
h = histogram(data1, nBins)
hold on
histogram(data2, nBins);  
legend('distribution 1', 'distribution 2')


%% Scatter Plots

figure(3); clf;
nPts = 500;
mu = [0 0];
sigma = [.8 .7; .7 .8];
data = mvnrnd(mu, sigma, nPts);
scatter(data(:,1), data(:,2), 'filled')

%%  Add sizes

sizes = 25*rand(nPts,1);  %generate some random sizes
scatter(data(:,1), data(:,2), sizes,'filled')

%%  Add some colors

figure(3); 
clf;
data1 = mvnrnd(mu, sigma, nPts);
sizes = 25*rand(nPts,1);  %generate some random sizes
scatter(data1(:,1), data1(:,2), sizes, [1 0 0],'filled')
hold on
grid on
data2 = mvnrnd([ 0 3], sigma, nPts);
scatter(data2(:,1), data2(:,2), sizes, [0 0 1])


%%  Plot an image

figure(4); clf;
data = peaks;
imagesc(data);
colorbar
% colormap parula;   % this is the default, you don't need to write this
% colormap jet
% colormap bone
% colormap winter
% colormap spring
% colormap summer
% colormap hot

%%  3d plotting ===========================================================

%% Plot3

t = 0 : pi/50 : 10*pi;
st = sin(t);
ct = cos(t);

figure
plot3(st,ct,.1*t)
axis equal


%% Scatter 3

sigma = [1 .8 .5;
        .8 1 .8;
        .5 .8 1];
data = mvnrnd([0 0 0], sigma,1000);
scatter3(data(:,1), data(:,2), data(:,3),15,'filled')
axis equal

%% subplots ===============================================================

figure(5); clf;

subplot(2,1,1)
plot(rand(10,2))

subplot(2,1,2)
plot(rand(10,2))

% Take a look at the panel function on the matlab file exchange if you want
% more flexibility than subplots provides

%% slightly more complex subplots

x = linspace(-3.8,3.8);
y_cos = cos(x);
y_poly = 1 - x.^2./2 + x.^4./24;

figure
subplot(2,2,1);
plot(x,y_cos);
title('Subplot 1: Cosine')

subplot(2,2,2);
plot(x,y_poly,'g');
title('Subplot 2: Polynomial')

subplot(2,2,[3,4]);
plot(x,y_cos,'b',x,y_poly,'g');
title('Subplot 3 and 4: Both')

%%

figure(1); clf;
x = linspace(-pi, pi, 10)
data = rand(10,1);
plot(x,data,'mo-')
maxInd = find(data == max(data))
text(x(maxInd), data(maxInd),'text')

xlim([-10 10])
ylim([-2 2])


%%  Adujusting settins programmatically ===================================

% return to the basic line plot
figure(1); clf;
nPts = 12;
xdata = linspace(0,1,nPts);
ydata = rand(nPts,2);
figHandle = plot(xdata, ydata);

ylim([0 2])  % sets the y-axis limits
xlim([0 1.1])
grid on
xlabel('X axis label')
ylabel('Y axis label')
legend('data1','data2')
title('Plot Title')

%% Demo figure export


figName = 'Plot_20151013';
% print(figure(1), figName, '-dpdf', '-r300')
print(figure(1), figName, '-dpng', '-r300')


%%  Demo RGB color

figure(12); clf;

axis off
xlim([-1.2 1.2])
ylim([-1.2 1.2])
axis square
rh = rectangle('Position', [-1 -1 2 2]);
color = round(10*rand(1,3))/10;
set(rh,'FaceColor', color);
% r.FaceColor = rand(1,3);   %can also use dot notation


colorString = sprintf('Color = [%.1f, %.1f, %.1f]', color(1), color(2), color(3))
text(-.8,-1.1, colorString)



%%  Demo plot objects

figure(11); clf;

l2 = plot(rand(10,2));  %plot a couple of lines and store their handles;
set(l2(1),'Color',[.2 .7 1]) % set line 1 to have a certain color
set(l2(2),'linewidth',2)


%% demo figure object handles - axis children

figure(12); clf;
axChild = get(gca,'Children')

subplot 211
plot(rand(10,2))
legend(gca, 'show')

subplot 212
plot(rand(10,2))
legend(gca, 'show','location','northoutside')
figChild = get(gcf,'Children')


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
% waitforbuttonpress;

%% Adjust Line Properties
% Here, we change the color and style of the lines
set(hFit, 'Color', [0 0 .5]);
set(hE, 'LineStyle', 'none', 'Marker', '.', 'Color', [.3 .3 .3]);
set(hData, 'LineStyle', 'none', 'Marker', '.');
set(hModel, 'LineStyle', '--', 'Color', 'r');
set(hCI(1), 'LineStyle', '-.', 'Color', [0 .5 0]);
set(hCI(2), 'LineStyle', '-.', 'Color', [0 .5 0]);
%%
% Here, we change other properties: thickness of the lines, and size/color of the markers
set(hFit, 'LineWidth', 2);
set(hE, 'LineWidth', 1, 'Marker', 'o', 'MarkerSize', 6, 'MarkerEdgeColor', [.2 .2 .2], 'MarkerFaceColor', [.7 .7 .7]);
set(hData, 'Marker', 'o', 'MarkerSize', 5, 'MarkerEdgeColor', 'none', 'MarkerFaceColor', [.75 .75 1]);
set(hModel, 'LineWidth', 1.5);
set(hCI(1), 'LineWidth', 1.5);
set(hCI(2), 'LineWidth', 1.5);
%%
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
print -dpng finalPlot1.png

% Postprocess: We use the following function to make the lines a bit more visible:
% fixPSlinestyle('finalPlot1.eps', 'finalPlot2.eps');
