%% Case study 3: Circuits as Resonators, Sensors, and Filters
% *ESE 105* 
%
% *Name: FILL IN HERE*
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
R = 50;
L = 0.035;
C = 1e-6;
f = 440;

vC0 = 0;

Vc_i = zeros(2, 3000);
Vc_i(:, 1) = [vC0, 0];


for k = 1:2999
    Vc_i(:, k+1) = [1 h/C; -h/L (1 - R*h/L)]*Vc_i(:, k) + [0; h/L]*Vin(:, k);
end

vR = Vc_i(2, :)*R;
soundsc(vR, 1/h);
pause(3);
figure;
hold on;
plot(h.*(1:k+1), vR(1, :));
plot(h.*(1:k+1), Vin(1, :));
Vout = vR;
end