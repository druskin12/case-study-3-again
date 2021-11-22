%% PART 2: RESISTOR & INDUCTOR MODEL
clc;
clearvars;
close all;
%% Part 2.1 Find model for RL Circuit and Graph the Voltage and Current through Time
% initial values
R = 100;
L = 0.1;
h = 1e-6;
vR0 = 0;

% Voltage supplied to circuit
Vin = ones(1, 5000);
i = zeros(1, 5000);

% equation 20 implemented into a linear dynamical model to represent the RL model
for k=1:4999
    i(:,k+1) = (1-(h*R/L))*i(:,k) + (h/L)*Vin(k);
end

vR = i*R; % Voltage across resistor
vL = Vin - vR; % Voltage across inductor

% plot Voltage across Inductor
figure;
hold on;
plot(h.*(1:k+1), vL(1, :));
plot(h.*(1:k+1), Vin(1, :));
hold off;
xlabel('Time (s)');
ylabel('Voltage (V)');
legend('vL', 'Vin');
title('Voltage across Inductor (h = 1x10^-7)');

% plot current across inductor
figure;
plot(h.*(1:k+1), i(1, :));
xlabel('Time (s)');
ylabel('Current (A)');
title('Current across Inductor (h = 1x10^-7)');
