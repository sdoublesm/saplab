close all
clc
clear

format long;
x = 20; 
n = -x:x; % extension
 
%% (a): |a| < 1
a1 = 0.5;

x1 = a1.^abs(n);  % Calculate x[n] for case (a)
% returns a vector

% stem plots singular lines for each sample
% plot (a)
figure;
stem(n, x1, 'filled');
title('x[n] = a^{|n|}, |a| < 1');
xlabel('n');
ylabel('x[n]');
grid on;

%% (b): |a| >= 1
a2 = 1.5;  % a is greater than or equal to 1
x2 = a2.^abs(n);

% plot (b)
figure;
stem(n, x2, 'filled');
title('x[n] = a^{|n|}, |a| \geq 1');
xlabel('n');
ylabel('x[n]');
grid on;

%% Determine energy and average power and compare the results to the theory
E1 = sum(x1.^2);
fprintf('Approximate Energy of the signal for |a| < 1 (a = %.2f): %.10f\n', a1, E1);
P1 = 1/(2*x+1)*E1;
fprintf('Approximate average power of the signal for |a| < 1 (a = %.2f): %.4f\n', a1, P1);
E2 = sum(x2.^2);
fprintf('Approximate Energy of the signal for |a| > 1 (a = %.2f): %.4f\n', a2, E2);
P2 = 1/(2*x+1)*E2;
fprintf('Approximate average of the signal for |a| > 1 (a = %.2f): %.4f\n', a2, P2);

%% vector N of values of extension x
% What is the minimum extension size needed to estimate the energy/average power 
% with a relative error lower than 0.001 percent?
treshold = 0.00001;

% theoretical energy 
E_th = (1+a1^2)/(1-a1^2);
% E_approx into EN

N = [5 10 15 20 25 30 40 50 70 100 300 500]; % increasing n

EN = zeros(8, 1); % inizializing vector of energy values
% fill vector -> to plot
for i=1:12
    n = -N(i):N(i);
    % x3 equal to x1 but with different n at each iteration
    x3 = a1.^abs(n);
    EN(i) = sum(x3.^2);
end 

% find the minimum size
for i = 1:12
    rel_error = abs(E_th - EN(i)) / E_th;
    if rel_error <= treshold
        fprintf("Minimum size of extension: %f\n", N(i));
        break;
    end
end

% approx energy and theoretical energy vs extension N
figure;
plot(N, EN, '-o');
hold on;
yline(E_th, 'r--', 'Theoretical Energy');
title('approx energy and theoretical energy vs extension N');
xlabel('Extension size');
ylabel('Energy');
legend('Numerical Estimate', 'Theoretical Value');
grid on;

% notes:
% piu a si avvicina ad 1 piu la dimensione minima sale -> piu l'errore e grande
% serie converge meno rapidamente