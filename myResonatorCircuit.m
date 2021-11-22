%% Case study 3: Circuits as Resonators, Sensors, and Filters
% *ESE 105* 
%
% *Name: Daniel Ruskin, Emma Bateman, William Yin*
%
% function myResonatorCircuit(Vin,h) receives a time-series voltage sequence
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

function Vout = myResonatorCircuit(Vin,h)
R = 15.915; % can try to increase to less than 15.92
L = 100e-3;
C = .3275e-6;
% Vin1 = zeros(1, length(Vin));
% transferFunction = zeros(1, 9991);
% 
% vC0 = 0;
% 
% Vc_i = zeros(2, length(Vin));
% Vc_i(:, 1) = [vC0, 0];
% 
% for f = 1:9991
%    for k = 1:4999
%        Vin1(1, k) = sin(2*pi*(f + 9)*k*h);
%        Vc_i(:, k+1) = [1 h/C; -h/L (1 - R*h/L)]*Vc_i(:, k) + [0; h/L]*Vin1(:, k);
%     end
%     Vout = Vc_i(2, :)*R;
%     transferFunction(1, f) = (norm(Vout))/(norm(Vin1));
% end
%  
% figure;
% plot(10:10000, transferFunction(1, :));
% xlabel('Frequency (Hz)');
% ylabel('V');

vC0 = 0;

Vc_i = zeros(2, 1e8);
Vc_i(:, 1) = [vC0, 0];
Vin2 = zeros(1e8, 1);
Vin2(2, 1) = 1;
for k = 1:(1e8 - 1)
    Vc_i(:, k+1) = [1 h/C; -h/L (1 - R*h/L)]*Vc_i(:, k) + [0; h/L]*Vin2(k, :);
end
Vout = Vc_i(2, :)*R;

figure;
hold on;
plot(h.*(1:k+1), Vout(1, :));
plot(h.*(1:k+1), Vin2(:, 1));
hold off;
legend('vR', 'Vin');
xlabel('Time (s)');
ylabel('Voltage (V)');
title('Voltage across Resistor, f = 880 Hz');
end