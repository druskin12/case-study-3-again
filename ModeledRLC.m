clc;
clearvars;
close all;


R = 50;
L = 0.035;
C = 1e-6;

h = 1/192000;
vC0 = 0;

Vin = ones(1, 100000);
Vc_i = zeros(2, 100000);
Vc_i(:, 1) = [vC0, 0];

%%
for k = 1:99999
    Vc_i(:, k+1) = [1 h/C; -h/L (1 - R*h/L)]*Vc_i(:, k) + [0; h/L]*Vin(:, k);
end

vR = Vc_i(2, :)*R;
soundsc(vR, 1/h);
pause(3);
figure;
hold on;
plot(h.*(1:k+1), vR(1, :));
plot(h.*(1:k+1), Vin(1, :));
xlim([0, 0.015]);
%%
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
plot(h.*(1:k+1), Vin(1, :));
xlim([0, 0.015]);
%%
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
plot(h.*(1:k+1), Vin(1, :));
hold off;
xlim([0, 0.015]);
xlabel('Time (s)');
ylabel('Voltage (V)');
title('Voltage across Resistor (h = 1/192000)');

%%
R = 100;
L = 100e-3;
C = .1e-6;
transferFunction = zeros(1, 9991);

Vin = zeros(1, 5000);
Vc_i = zeros(2, 5000);
vC0 = 0;
Vc_i(:, 1) = [vC0, 0];
for f = 1:9991
    for k = 1:4999
        Vin(1, k) = sin(2*pi*(f + 9)*k*h);
        Vc_i(:, k+1) = [1 h/C; -h/L (1 - R*h/L)]*Vc_i(:, k) + [0; h/L]*Vin(:, k);
    end
    vR = Vc_i(2, :)*R;
    transferFunction(1, f) = (norm(vR))/(norm(Vin));
end

figure;
plot(10:10000, transferFunction(1, :));
xlabel('Frequency (Hz)');
ylabel('V');

%%

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
    vR = Vc_i(2, :)*R;
    playSound(vR, 1/h);
    pause(3);
    figure;
    hold on;
    plot(h.*(1:k+1), vR(1, :));
    plot(h.*(1:k+1), Vin(1, :));
    hold off;
    xlim([0, 0.030]);
    legend('vR', 'Vin');
    xlabel('Time (s)');
    ylabel('Voltage (V)');
    title(['Voltage across Resistor, f = ',num2str(f)]);
end

