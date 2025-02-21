close all
clc
clear

n = 0:3;  % n ranges from 0 to 3 for non-zero components

% indicator functions (n==k) return 1 when true and 0 otherwise 
% useful to simulate deltas
x_n = 3*(n==0) + 2*(n==1) - 1*(n==2) + 4*(n==3);
x_n = x_n'; % signal as a column vector

% get the length of the signal, so the extension N
N = length(x_n);
fprintf('The extension length is: %d\n', N);

% plot of x[n]
figure;
stem(n, x_n, 'filled');
title('x[n] = 3\delta[n] + 2\delta[n-1] - \delta[n-2] + 4\delta[n-3]');
xlabel('n');
ylabel('x[n]');
grid on;

%% CANONICAL BASIS
% Considering the canonical basis represented by the matrix U_c
% that is equal to the identity matrix I
U_c = eye(N);
% compute the coefficients obtained by projecting x[n] on the new basis
% this corresponds to the vector c = U'x.
c_c = U_c'*x_n
x_c = U_c*c_c; % reconstruction 

% required output: Figure representing the signal projected on the new basis;
% so plot c versus N
figure;
stem(n, c_c, 'filled');
title('x[n] projected on the canonical basis');
xlabel('n');
ylabel('c_c');
grid on;

%% FOURIER BASIS
% considering the Fourier basis represented by the matrix U_f

w=exp(1j*2*pi/N);
U_f = zeros(N, N);

for i = 1:N
    for k = 1:N
        % element F(k, j) following the definition
        U_f(i, k) = 1 / sqrt(N) * w.^((i-1)*(k-1));
    end
end

c_f = U_f'*x_n % to plot
% x_f = U_f*c_f; % reconstruction

% Plot real and imaginary parts of x[n] vs n
figure;
stem(n, real(c_f), 'b', 'filled', 'DisplayName', 'Real Part of c_f');  % Real part in blue
hold on;
stem(n, imag(c_f), 'r', 'filled', 'DisplayName', 'Imaginary Part of c_f'); % Imaginary part in red
hold off;
title('x[n] projected on the Fourier basis');
xlabel('n');
ylabel('c_f');
legend('show');
grid on;

%% GENERATING A NEW BASIS
% A = randn(N) % inizializza una matrice n x n di numeri casuali
A = [
    1.0933,  -1.2141,  -0.7697,  -1.0891;
    1.1093,  -1.1135,   0.3714,   0.0326;
   -0.8637,  -0.0068,  -0.2256,   0.5525;
    0.0774,   1.5326,   1.1174,   1.1006
];

U_g = zeros(N, N);
% Gram-Schmidt algorithm to orthonormalize the matrix
for i = 1:N
    % current vector
    v = A(:, i);
    
    % remove components
    for j = 1:i-1
        v = v - (U_g(:, j)' * v) * U_g(:, j);
    end
    
    % normalization
    U_g(:, i) = v / norm(v);
end

U_g

c_g = U_g'*x_n % to plot
x_g = U_g*c_g % reconstruction

figure;
stem(n, c_g, 'filled');
title('x[n] projected on the generic basis');
xlabel('n');
ylabel('c_g');
grid on;