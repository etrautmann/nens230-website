%% Plots the fourier transform of a signal
%  Niru Maheswaranathan
%  Nov 4, 2013

function [freq, magnitude] = plotfft(x, fs)

    % compute the FFT
    F = fft(x);
    
    % get the magnitude of the first half of the FFT
    magnitude = abs(F(1:floor(length(F)/2)));
    %power     = (F(1:floor(length(F)/2))) .^ 2;
    
    % make the corresponding frequency vector
    freq = linspace(0, fs/2, length(magnitude));
    
    % make the plot
    plot(freq, magnitude, 'k-');
    xlabel('Frequency (Hz)');
    ylabel('Magnitude');
