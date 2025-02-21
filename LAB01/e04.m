clear
close all
clc
format short;

N = 128;
U_w = generateWalshBasis(128);

n = 0:N-1;
x_n = zeros(N, 1);
x_n(6:93) = 1;

% original signal plot
figure;
stem(n, x_n, 'filled');
title('x[n] = r_{88}[n-5]');
xlabel('n');
ylabel('x[n]');
grid on;

%% CANONICAL BASIS
U_c = eye(N);
c_c = U_c'*x_n;

figure;
stem(n, c_c, 'filled');
title('x[n] projected on the canonical basis');
xlabel('n');
ylabel('c_c');
grid on;

%% FOURIER BASIS
w=exp(1j*2*pi/N);
U_f = zeros(N, N);

for i = 1:N
    for k = 1:N
        U_f(i, k) = 1 / sqrt(N) * w.^((i-1)*(k-1));
    end
end

c_f = U_f'*x_n;

% plot real and imaginary parts of x[n] vs n
figure;
stem(n, real(c_f), 'b', 'filled', 'DisplayName', 'Real Part of c_f');
hold on;
stem(n, imag(c_f), 'r', 'filled', 'DisplayName', 'Imaginary Part of c_f');
hold off;
title('x[n] projected on the Fourier basis');
xlabel('n');
ylabel('c_f');
legend('show');
grid on;

%% WALSH BASIS (U_W)
c_w = U_w'*x_n;
x_w = U_w*c_w; % reconstruction

figure;
stem(n, c_w, 'filled');
title('x[n] projected on the Walsh basis');
xlabel('n');
ylabel('c_w');
grid on;


%% is Parseval equaity verified??
% E1 = sum(x_n.^2);
% is equal to ...
% E_c = sum(c_c)
% E_f = sum(c_f)
% E_w = sum(c_w)

E1 = sum(abs(x_n).^2)
E_c = sum(abs(c_c).^2)
E_f = sum(abs(c_f).^2)
E_w = sum(abs(c_w).^2)