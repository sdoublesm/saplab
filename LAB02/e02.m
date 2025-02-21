clear;
close all;
clc;

% numerator and denominator coefficients of H(z)
B = [1 2];
A = [1 -3/5 -1/9];

[R, P, ~] = residue(B, A);
disp('Residues for H(z):');
disp(R);
disp('Poles for H(z):');
disp(P);

n = 0:30;
N = size(n); N = N(2);

% impulse response using residues and poles (ANALYTICAL WAY)
h = zeros(size(n));
for i = 1:length(P)
    h = h + R(i) * (P(i) .^ (n-1)).*double(n>=1);
end

figure;
stem(n, h, 'filled');
xlabel('n');
ylabel('h[n]');
title('Analytical impulse response');

% MATLAB computed impulse response
delta = [1, zeros(1, N-1)]; % Impulse signal
h2 = filter(B, A, delta);
h2 = [0, h2(1:end-1)]; % allineamento risultato analitico e filter;
% serve per diversa convenzione temporale tra filter e formula analitica

figure;
stem(n, h2, 'filled');
xlabel('n');
ylabel('h[n]');
title('MATLAB-computed impulse response');

% last point

% input
x = (1/2).^(n);
figure;
stem(n, x, 'filled');
xlabel('n');
ylabel('x[n]');
title('Input signal');

% numerator and denominator coefficients
B2 = [1 2 0];
A2 = [1 -11/10 17/90 1/18];
[R, P, ~] = residue(B2, A2);

% analytical expr
y = zeros(size(n));
for i = 1:length(P)
    y = y + R(i) * (P(i).^(n-1)).*double(n>=1);
end

figure;
stem(n, y, 'filled');
xlabel('n');
ylabel('y[n]');
title('Analytical output signal');

% via script - use of filter
y2 = filter(B, A, x);
y2 = [0, y2(1:end-1)]; % allineamento risultato analitico e filter

figure;
stem(n, y2, 'filled');
xlabel('n');
ylabel('y[n]');
title('MATLAB-computed output signal');