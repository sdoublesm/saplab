close all;
clc;
clear;

[file, Fs] = audioread("close.mp3"); 
load('FIR_impluse_response_1.mat'); %filter contains arrays h and taps

duration = 10; % 10 seconds of audio
audio_segment = file(1:duration*Fs);

N = length(audio_segment);
f = (-N/2:N/2-1) * (Fs / N); % frequency axis for FFT

%% filtering with linear convolution in time domain
filtered_audio_time_domain = conv(audio_segment, h, 'same');

%% circular convolution with DFT
M = length(h);
L = N + M - 1;  % length of the zero-padded signal
L = 2^nextpow2(L);

audio_segment = audio_segment';
% zero-padding
audio_padded = [audio_segment; zeros(L-N, 1)];  
h_padded = [h; zeros(L-M, 1)];

X_audio = fft(audio_padded, L);  
H_filter = fft(h_padded, L); 

% circular convolution by multiplying the DFTs
Y_circular = ifft(X_audio .* H_filter);  % inverse DFT

filtered_audio_circular = Y_circular(1:N);  % truncate to remove the padded section

%% plot audio signals and energy spectra
figure;
plot((1:N)/Fs, audio_segment);
title('Original Audio Signal');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;

figure;
plot((1:N)/Fs, filtered_audio_time_domain);
title('Filtered Audio Signal (Time Domain Filtering)');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;

figure;
plot((1:N)/Fs, filtered_audio_circular);
title('Filtered Audio Signal (Circular Convolution via DFT)');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;

%% FFT - Energy Spectrum
X_k_original = fft(audio_segment); 
X_k_time_filtered = fft(filtered_audio_time_domain); 
X_k_circular_filtered = fft(filtered_audio_circular); 

X_k_original_shifted = fftshift(X_k_original);
X_k_time_filtered_shifted = fftshift(X_k_time_filtered);
X_k_circular_filtered_shifted = fftshift(X_k_circular_filtered);

energy_original = abs(X_k_original_shifted).^2;
energy_time_filtered = abs(X_k_time_filtered_shifted).^2;
energy_circular_filtered = abs(X_k_circular_filtered_shifted).^2;

energy_dB_original = 10 * log10(energy_original); 
energy_dB_time_filtered = 10 * log10(energy_time_filtered);  
energy_dB_circular_filtered = 10 * log10(energy_circular_filtered);

figure;
plot(f, energy_dB_original);
title('Energy Spectrum Before Filtering');
xlabel('Frequency (Hz)');
ylabel('Energy (dB)');
grid on;

figure;
plot(f, energy_dB_time_filtered);
title('Energy Spectrum After Time Domain Filtering');
xlabel('Frequency (Hz)');
ylabel('Energy (dB)');
grid on;

figure;
plot(f, energy_dB_circular_filtered);
title('Energy Spectrum After Circular Convolution Filtering');
xlabel('Frequency (Hz)');
ylabel('Energy (dB)');
grid on;

%% play the original and filtered audio using soundsc
disp('Playing the original audio...');
soundsc(audio_segment, Fs);  % Play the original audio signal
pause(duration + 1);

disp('Playing the filtered audio (Time Domain Filtering)...');
soundsc(filtered_audio_time_domain, Fs);
pause(duration + 1);

disp('Playing the filtered audio (Circular Convolution via DFT)...');
soundsc(filtered_audio_circular, Fs);