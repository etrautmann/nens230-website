% dataset 1 (multivariant correlated random)

% n = 1000;
% mu = [0 0 0];
% sig = [1 0.7 .3;
%         .7 1 .7;
%         .3 .7 1;];
% D = mvnrnd(mu,sig,n);
% 
% figure(8); clf;
% x = D(:,1);
% y = D(:,2);
% z = D(:,3);


% fake data 2 (ring)
% 
nPoints = 200;
nEmbeddingDimensions = 50;
noiseSD = 0.1;

% generate random points on a circle
angles = 2*pi*rand(nPoints,1);
radii = 8 + 0.2*randn(nPoints,1);
origX = cos(angles).*radii;
origY = sin(angles).*radii;

origEmbedded = [origX origY noiseSD*randn(nPoints, nEmbeddingDimensions-2)];

rotated = (randn(nEmbeddingDimensions)*origEmbedded')';
x = rotated(:,1);
y = rotated(:,2);
z = rotated(:,3);



% plot given datsaset

figure(7), clf, set(7, 'Color', 'w');
plot3(x,y,z, 'b.', 'MarkerSize', 12);
xlabel('x');
ylabel('y');
zlabel('z');
title('Demo Data, pre-PCA');
box on;
axis equal


%% Make histograms in x, y, z

figure(8), clf, set(8, 'Color', 'w');

subplot(2,2,3);
plot(x,y,'ko', 'MarkerSize', 5, 'MarkerFaceColor', 'k');
xlabel('x');
ylabel('y');
box off

subplot(2,2,4);
plot(z,y,'ko', 'MarkerSize', 5, 'MarkerFaceColor', 'k');
xlabel('z');
ylabel('y');
box off

subplot(2,2,1);
plot(x,z,'ko', 'MarkerSize', 5, 'MarkerFaceColor', 'k');
xlabel('x');
ylabel('z');
box off

%% Run PCA to find orthogonal axes with largest variance

% Build the data matrix. Each row is an observation, each column is a
% dimension or measurement (x, y, z)

data = [x y z];

% subtract the means off each column and normalize the variance
dataNormalized = zscore(data);

[coeff score latent] = pca(data);


figure(7); 
hold on

for ii = 1:3
    vector = [zeros(1,3); coeff(:,ii)']*sqrt(latent(ii))
    plot3(vector(:,1),vector(:,2),vector(:,3),'r')
end

axis equal

%%
figure(9), clf, set(9, 'Color', 'w');
plot(score(:,1), score(:,2), 'ko', 'MarkerSize', 5, 'MarkerFaceColor', 'k');
xlabel('PC 1');
ylabel('PC 2');
title('Demo Data, post-PCA');
box off;
axis equal


