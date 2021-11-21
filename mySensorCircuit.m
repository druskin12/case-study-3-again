%% Case study 3: Circuits as Resonators, Sensors, and Filters
% *ESE 105* 
%
% *Name: FILL IN HERE*
%
% function mySensorCircuit(Vin,h) receives a time-series voltage sequence
% sampled with interval h, and returns the output voltage sequence produced
% by a circuit
%
% inputs:
% Vin - time-series vector representing the voltage input to a circuit
% h - scalar representing the sampling interval of the time series in
% seconds
%
% outputs:
% Vout - time-series vector representing the output voltage of a circuit

function Vout = mySensorCircuit(Vin,h)
R = 100;
L = 40.6;
C = .1e-6;
transferFunction = zeros(1, 9991);

vC0 = 0;

Vc_i = zeros(2, length(Vin));
Vc_i(:, 1) = [vC0, 0];

for f = 1:9991
   for k = 1:4999
       Vin(k, 1) = sin(2*pi*(f + 9)*k*h);
       Vc_i(:, k+1) = [1 h/C; -h/L (1 - R*h/L)]*Vc_i(:, k) + [0; h/L]*Vin(k, :);
    end
    Vout = Vc_i(2, :)*R;
    transferFunction(1, f) = (norm(Vout))/(norm(Vin));
 end
 
figure;
plot(10:10000, transferFunction(1, :));
xlabel('Frequency (Hz)');
ylabel('V');

vC0 = 0;

Vc_i = zeros(2, length(Vin));
Vc_i(:, 1) = [vC0, 0];

for k = 1:(length(Vin) - 1)
    Vc_i(:, k+1) = [1 h/C; -h/L (1 - R*h/L)]*Vc_i(:, k) + [0; h/L]*Vin(k, :);
end
Vout = Vc_i(2, :)*R;

figure;
hold on;
plot(h.*(1:k+1), Vout(1, :));
plot(h.*(1:k+1), Vin(:, 1));
hold off;
legend('vR', 'Vin');
xlabel('Time (s)');
ylabel('Voltage (V)');
title('Voltage across Resistor, f = 880');
end