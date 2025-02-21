close all;
clc;
clear;

% ! bigger window size implies a bigger amplitude, so bigger values of energy and values are different for the different windows we choose
[file, Fs] = audioread("close.mp3");
% Fs in Hz

fprintf("Sampling frequency: %d\n", Fs)

samples = length(file); % number of samples
duration = samples / Fs; % duration in seconds

% [0.5 2 50 200]
for K = [0.5 1]
    W = Fs*K; % windows duration
    
    window = file(1:W); % modify the range to get the desired window  
    % Fs samples corresponds to 1 second
    
    % audio signal plot 
    figure;
    plot(1:W, window); % modify the interval to plot correctly
    xlabel('n');
    ylabel('digital info');
    title('close.mp3');
    grid on;

    % ---- FFT
    tic()
    X_k = fft(window);
    fprintf("[FFT] M: %-10d - ", W);
    toc()
    % fftshift to center the spectrum
    X_k_shifted = fftshift(X_k);

    energy_shifted = abs(X_k_shifted).^2;
    fft_dB_shifted = 10 * log10(energy_shifted);

    freq = (-W/2 : W/2 - 1);

    figure;
    plot(freq, fft_dB_shifted);
    xlabel('Frequency (Hz)');
    ylabel('Magnitude (dB)');
    title(sprintf("[FFT] Frequency Spectrum (Centered) in dB. Window size: %d", W));
    grid on;

    % ---- Manual DFT
    X = zeros(1, W);
    tic()
    for k = 1:W
        X(k) = 0;
        for n = 1:W
            X(k) = X(k) + window(n) * exp(-1j * 2 * pi * (k-1) * (n-1) / W);
        end
        perc = k/W*100;
        if perc==20 || perc==50 || perc==80 || perc==100
            fprintf("[DFT] M: %-10d - %d percent elaborated.\n", W, perc);
        end
        
    end
    fprintf("[DFT] M: %-10d - ", W);
    toc()

    % manually centering DFT
    X_k_shifted = [X(W/2+1:end), X(1:W/2)];  % move the half dx part to the beginning

    energy_shifted = abs(X_k_shifted).^2;
    dft_dB_shifted = 10 * log10(energy_shifted);
    
    figure;
    plot(freq, dft_dB_shifted);
    xlabel('Frequency (Hz)');
    ylabel('Magnitude (dB)');
    title(sprintf("[DFT] Frequency Spectrum (Centered) in dB. Window size: %d", W));
    grid on;

end