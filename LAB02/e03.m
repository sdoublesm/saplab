close all; 
clear; 
clc;

k1 = 1/4;
k2 = 3/4;
k3 = -3/4;

% Transfer function H(z)
num = [1/4, 3/4, -3/4];
den = [1, 0, 0];

N = 15;

% delta signal
delta = [1, zeros(1, N-1)];

% impulse response h[n] using filter
h = filter(num, den, delta);

% x[n] = r5[n-3]
n = 0:N-1;
x = 1*(n>=3 & n<=7);

% output y[n] using filter
y = filter(num, den, x);

% plots
figure;
stem(n, x, 'filled');
title('Input Signal x[n]');
xlabel('n');
ylabel('x[n]');
grid on;

figure;
stem(n, h, 'filled');
title('Impulse Response h[n]');
xlabel('n');
ylabel('h[n]');
grid on;

figure;
stem(n, y, 'filled');
title('Output Signal y[n]');
xlabel('n');
ylabel('y[n]');
grid on;

disp('Impulse Response h[n]:');
disp(h');
disp('Output Signal y[n]:');
disp(y');