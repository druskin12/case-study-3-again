%% PART 3: COMBINING RC AND RL MODEL INTO AN RLC CIRCUIT
clc;
clearvars;
close all;
%% Part 3.1 RLC Model 

% initial parameters
R = 50;
L = 0.035;
C = 1e-6;

h = 1/192000;
vC0 = 0;

% voltage supplied to circuit
Vin = ones(1, 100000);
Vc_i = zeros(2, 100000);
Vc_i(:, 1) = [vC0, 0];

% combined linear dynamical model for RLC model 
for k = 1:99999
    Vc_i(:, k+1) = [1 h/C; -h/L (1 - R*h/L)]*Vc_i(:, k) + [0; h/L]*Vin(:, k);
end
%% Part 3.2 Explore the Effects of that the Values of R, L, and C have on the Model
% description: starts loud and then simmers out
% voltage of resistor
vR = Vc_i(2, :)*R;
% listen to sound vR
soundsc(vR, 1/h);
pause(3);
% plot voltage of resistor across time
figure;
hold on;
plot(h.*(1:k+1), Vin(1, :));
plot(h.*(1:k+1), vR(1, :));
xlim([0, 0.015]);

% increase R and L
% decrease C
R = 100;
L = 0.5;
C = 2e-8;
Vc_i = zeros(2, 100000);
Vc_i(:, 1) = [vC0, 0];

for k = 1:99999
    Vc_i(:, k+1) = [1 h/C; -h/L (1 - R*h/L)]*Vc_i(:, k) + [0; h/L]*Vin(:, k);
end

vR = Vc_i(2, :)*R;
soundsc(vR, 1/h);
pause(3);
plot(h.*(1:k+1), vR(1, :));
xlim([0, 0.015]);

% increase C
R = 100;
L = 0.5;
C = 5e-8;
Vc_i = zeros(2, 100000);
Vc_i(:, 1) = [vC0, 0];

for k = 1:99999
    Vc_i(:, k+1) = [1 h/C; -h/L (1 - R*h/L)]*Vc_i(:, k) + [0; h/L]*Vin(:, k);
end

vR = Vc_i(2, :)*R;
soundsc(vR, 1/h);
plot(h.*(1:k+1), vR(1, :));
hold off;
xlim([0, 0.015]);
xlabel('Time (s)');
ylabel('Voltage (V)');
legend ('Vin = 1', 'R = 50,L = 0.035,C = 1e-6','R = 100,L = 0.5,C = 2e-8','R = 100,L = 0.5,C = 5e-8');
title('Voltage across Resistor (h = 1/192000)');

%% Part 3.3 Send Sinusoidal Voltages to Circuit and Test Different Frequencies
% given parameters
R = 100;
L = 100e-3;
C = .1e-6;
% Vout/Vin = transferFunction
transferFunction = zeros(1, 9991);
% Voltage supplied to circuit
Vin = zeros(1, 5000);
Vc_i = zeros(2, 5000);
vC0 = 0;
Vc_i(:, 1) = [vC0, 0];
% create table of transferFunction (Vout/Vin) for each frequency 
for f = 1:9991
    for k = 1:4999
        Vin(1, k) = sin(2*pi*(f + 9)*k*h); % frequency starts at 10; ends at 10,000
        Vc_i(:, k+1) = [1 h/C; -h/L (1 - R*h/L)]*Vc_i(:, k) + [0; h/L]*Vin(:, k);
    end
    vR = Vc_i(2, :)*R;
    transferFunction(1, f) = (norm(vR))/(norm(Vin));
end
% plot transferFunction over fequency
figure;
plot(10:10000, transferFunction(1, :));
xlabel('Frequency (Hz)');
ylabel('Vout / Vin');
title('Transfer Function across Different Frequencies');
% Explore five specific frequencies over a given time
% 5 frequencies below
freq = [10, 100, 1000, 1592, 10000];
for i = 1:5
    f = freq(i);
    Vc_i = zeros(2, 100000);
    Vc_i(:, 1) = [vC0, 0];
    Vin = zeros(1, 100000);
    
    for k = 1:99999
        Vin(1, k) = sin(2*pi*f*k*h);
        Vc_i(:, k+1) = [1 h/C; -h/L (1 - R*h/L)]*Vc_i(:, k) + [0; h/L]*Vin(:, k);
    end
    % listen to sound of the specific frequency
    vR = Vc_i(2, :)*R;
    playSound(vR, 1/h);
    pause(3);
    % plot frequency's voltage across resistor over time
    figure;
    hold on;
    plot(h.*(1:k+1), vR(1, :)); % voltage across resistor
    plot(h.*(1:k+1), Vin(1, :)); % input voltage
    hold off;
    xlim([0, 0.030]);
    legend('vR', 'Vin');
    xlabel('Time (s)');
    ylabel('Voltage (V)');
    title(['Voltage across Resistor, f = ',num2str(f)]);
end

