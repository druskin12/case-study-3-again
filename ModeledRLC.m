clc;
clearvars;
close all;


R = 50;
L = 0.035;
C = 1e-6;

h = 1/192000;
vC0 = 0;
i0 = 0;

Vin = ones(1, 3000);
Vc_i = zeros(2, 3000);
Vc_i(:, 1) = [vC0, 0];

%%
for k = 1:2999
    Vc_i(:, k+1) = [1 h/C; -h/L (1 - R*h/L)]*Vc_i(:, k) + [0; h/L]*Vin(:, k);
end

vR = Vc_i(2, :)*R;
soundsc(vR);
pause(3);
figure;
hold on;
plot(h.*(1:k+1), vR(1, :));
plot(h.*(1:k+1), Vin(1, :));
%%
R = 100;
L = 0.5;
C = 2e-8;

for k = 1:2999
    Vc_i(:, k+1) = [1 h/C; -h/L (1 - R*h/L)]*Vc_i(:, k) + [0; h/L]*Vin(:, k);
end

vR = Vc_i(2, :)*R;
soundsc(vR);
pause(3);
plot(h.*(1:k+1), vR(1, :));
plot(h.*(1:k+1), Vin(1, :));
%%
R = 100;
L = 0.5;
C = 5e-8;

for k = 1:2999
    Vc_i(:, k+1) = [1 h/C; -h/L (1 - R*h/L)]*Vc_i(:, k) + [0; h/L]*Vin(:, k);
end

vR = Vc_i(2, :)*R;
soundsc(vR);
plot(h.*(1:k+1), vR(1, :));
plot(h.*(1:k+1), Vin(1, :));
hold off;
xlabel('Time (s)');
ylabel('Voltage (V)');
title('Voltage across Resistor (h = 1/192000)');