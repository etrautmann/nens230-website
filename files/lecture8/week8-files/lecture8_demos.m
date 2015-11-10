% lecture 8 demos
% Eric Trautmann
% 2015

clear all
clc



%% plot FFT of square wave

fs = 10000;
tPts = -2:1/fs:2;
squareWave = square(tPts*(2*pi));

figure(5); clf;
plot(tPts,squareWave,'b','linewidth',1.5)
ylim([-2 2])
grid on
hold on

% build up the fourier series using a for loop to add successive frequency
% components, since everything adds linearly.  Note that we know the closed
% form solution to the sine wave, and this doesn't not work for arbitrary
% signals.
sig = zeros(size(tPts));

nComponents = 10
for ii = 1: 2 :2*(nComponents-1)+1
    sig = sig + 4/pi*(sin(tPts*2*pi*ii))/ii;
end

plot(tPts,  sig, 'r','linewidth',2)
xlabel('Time')







%% ========================================================================
%  Demo of aliasing (sampling too slow relative to a signal frequency)

clear all
clc

startTime = 0;
endTime = 5;

samplingRate = 20;

t = (startTime : 1/samplingRate : endTime);
y = sin(t*2*pi);

% much faster sampling (illustrate the signal as ground truth)
t2 = (startTime : 1/100 : endTime);
y2 = sin(t2*2*pi);

figure(1); clf;
plot(t,y,'o-','linewidth',1.4)
hold on
grid on
plot(t2,y2,'b-', 'linewidth',.5,'color',[.3 .3 .3])
title(['Samp. rate: ' num2str(samplingRate)])
xlim([startTime, endTime])


xlabel('Time (S)')
ylabel('Signal Amplitude (V)')
xlim([startTime, endTime])
ylim([-1.2 1.2])








%% ========================================================================
%  Example of recording audio and plotting signal and FFT

% Record your voice for 5 seconds.
sampFreq = 40000;
recObj = audiorecorder(sampFreq, 16,1);
disp('Start speaking.')
recordblocking(recObj, 2);
disp('End of Recording.');

%% Play back the recording.
 play(recObj);

% Store data in double-precision array.
myRecording = getaudiodata(recObj);

% Plot the waveform.
figure(3);
clf
plot(myRecording,'-');

%% Plot the fft of the recorded signal

figure(4); clf;
plotfft(myRecording, sampFreq);







%% ========================================================================
% Example filtering demo, remove 60Hz noise from some synthetic spiking data

% create some fake data signal with something that looks like spikes (sort
% of)
tPts = -pi:1/10:pi;
fakeSpike = sinc(tPts)';
signal = [  zeros(1000,1);
    fakeSpike;
    zeros(2000,1);
    fakeSpike;
    zeros(500,1);
    fakeSpike;
    zeros(4000-741,1);
    fakeSpike;
    zeros(1000,1);
    fakeSpike;
    zeros(1000,1);
    fakeSpike;
    zeros(400,1);
    fakeSpike;
    zeros(400,1)];

fs = 10000;
tMax = length(signal)/fs;
tPts = linspace(0,tMax, fs*tMax);

noise = .1*sin(2*pi*60*tPts)';
noisySig = signal+noise;

figure(14); clf;
subplot(211)
plot(noisySig,'b')
hold on
xlim([0 10000])
% plot(noise,'r')

%%

% you'll have to design a filter here using fdatool.  Then export the
% filter coefficients to the variable filtCoeff into the base workspace.

fdatool; % launches the filter design and analysis tool

%%

subplot(212)
plot(conv(noisySig, filtCoeff))
xlim([0 10000])







%% ========================================================================
%  Image processing demo

I = imread('rice.png');
figure(11); clf;
imshow(I)


%%

background = imopen(I,strel('disk',15));

figure(12); clf;
surf(double(background(1:8:end,1:8:end))),zlim([0 255]);
set(gca,'ydir','reverse');

%%

I2 = I - background;
imshow(I2)

%%

I3 = imadjust(I2);
imshow(I3);

%%


level = graythresh(I3);
bw = im2bw(I3,level);
bw = bwareaopen(bw, 50);
imshow(bw)

%%

cc = bwconncomp(bw, 4)
cc.NumObjects

%%

grain = false(size(bw));
grain(cc.PixelIdxList{50}) = true;
imshow(grain)

%%






