close all
clear
clc

N = 8;
n = 0:N-1;

%% x[n]
x_n = exp(1j * (4 * pi * n / N));

x_real = real(x_n);
x_imag = imag(x_n);

% plot real and imaginary parts of x[n] using stem
figure;
stem(n, x_real, 'b', 'filled', 'DisplayName', 'Real Part of x[n]');
hold on;
stem(n, x_imag, 'r', 'DisplayName', 'Imaginary Part of x[n]');
hold off;
title('Real and Imaginary Parts of x[n]');
xlabel('n');
ylabel('x[n]');
legend('show');
grid on;

E_x = sum(abs(x_n).^2); % energy of x[n]
P_x = E_x / length(n); % power of x[n]

fprintf('Energy of x[n]: %.4f\n', E_x);
fprintf('Power of x[n]: %.4f\n', P_x);

%% y[n]
y_n = exp(1j * (8 * pi * n / N));

y_real = real(y_n);
y_imag = imag(y_n);

% plot real and imaginary parts of y[n] using stem
figure;
stem(n, y_real, 'b', 'filled', 'DisplayName', 'Real Part of y[n]');
hold on;
stem(n, y_imag, 'r', 'DisplayName', 'Imaginary Part of y[n]');
hold off;
title('Real and Imaginary Parts of y[n]');
xlabel('n');
ylabel('y[n]');
legend('show');
grid on;

E_y = sum(abs(y_n).^2); % energy of y[n]
P_y = E_y / length(n); % power of y[n]

fprintf('Energy of y[n]: %.4f\n', E_y);
fprintf('Power of y[n]: %.4f\n', P_y);