clear;
clc;
close all;

N = 30; % number of samples 
n = 0:N-1;

% x[n]
A = 4; a = -3/4;
x = A.*a.^n .* (n>=0);

% plot
figure;
stem(n, x, 'filled');
title("x[n] = A a^nu[n]");
xlabel('n');
ylabel('x[n]');
grid on;


% y[n]
B = 2;
y = zeros(N, 1);
y(6:16) = B;


% plot
figure;
stem(n, y, 'filled');
title("y[n] = B r_{10}[n-5]");
xlabel('n');
ylabel('y[n]');
grid on;

%% (a) Convolution using the definition formula
% N_z = N_x + N_y -1 - EXTENSION OF THE CONVOLUTION
N_z = 2*N-1;
n_z = 0:N_z-1;
z_def = zeros(1, N_z);

% z[n] = x[n]°y[n] = sum for k from -inf to +inf of x[k]y[n-k]

for k = 1:N_z
    for i = 1:N
        if (i<=k) && (k-i+1 <= N)
            z_def(k) = z_def(k) + x(i) * y(k-i+1);
        end
    end
end

% plot
figure;
stem(n_z, z_def, 'filled');
title("convolution def");
xlabel('n');
ylabel('z[n]');
grid on;

%% (b) matrix
H = zeros(N_z, N);

for i = 1:N
    H(i:i+N-1, i) = y;  
end

z_matrix = H * x';  

% plot
figure;
stem(n_z, z_def, 'filled');
title("convolution with matrix");
xlabel('n');
ylabel('z[n]');
grid on;

%% (c) builtin
z_builtin = conv(x, y);

% plot
figure;
stem(n_z, z_def, 'filled');
title("convolution built-in");
xlabel('n');
ylabel('z[n]');
grid on;


%% Compare results
diff_def_builtin = max(abs(z_def' - z_builtin));
diff_matrix_builtin = max(abs(z_matrix - z_builtin));
diff_def_matrix = max(abs(z_def' - z_matrix));

% Display the differences
disp('Maximum absolute difference between definition and built-in conv:');
disp(diff_def_builtin);

disp('Maximum absolute difference between matrix computation andb built-in conv:');
disp(diff_matrix_builtin);

disp('Maximum absolute difference between definition and matrix computation:');
disp(diff_def_matrix);

%% Extension of the convolution 
fprintf('The convolution z[n] extends from %d to %d.\n', n_z(1), n_z(end));