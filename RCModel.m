clc;
clearvars;
close all;
h = 1e-05;
R = 1e3;
C = 1e-6;
vC0 = 0; 
vR0 = 0;

Vin = ones(1, 1000); % vin is 1 for all t > 1.
v = zeros(2,1000); 
v(:,1) = [vR0; vC0];

for k=1:999
    v(:,k+1) = [0 -(1-(h/(R*C))); 0 (1-(h/(R*C)))]*v(:,k) + [h/(R*C)-1; h/(R*C)]*Vin(k);
end

figure;
hold on;
plot(h.*(1:k+1), v(2,:));
plot(h.*(1:k+1), Vin(1,:));
hold off;
xlabel('Time (s)');
xlim([0,5e-3]);
ylabel('Voltage (V)');
legend('Vc', 'Vin');
title('Voltage across Capacitor (h = 1x10^-5)');

figure;
plot(h.*(1:k+1), v(2,:)/R);
xlabel('Time (s)');
ylabel('Current (A)');
title('Current across Capacitor (h = 1x10^-5)');

different_h = [1, 1e-1, 1e-2, 1e-3, 1e-4, 1e-5, 1e-6, 1e-7];
for i = 1:8
    h = different_h(i);
    v = zeros(2, 1000);
    v(:, 1) = [vR0; vC0];
    for j = 1:999
        v(:,j+1) = [0 -(1-(h/(R*C))); 0 (1-(h/(R*C)))]*v(:,j) + [h/(R*C)-1; h/(R*C)]*Vin(j);
    end
    figure();
    hold on;
    plot(h.*(1:j+1), v(2,:));
    plot(h.*(1:j+1), Vin(1,:));
    hold off;
    xlabel('Time (s)');
    ylabel('Voltage (V)');
    legend('Vc', 'Vin');
    title(['h = 1x10^-', num2str(i - 1)]);
end

v = zeros(2, 1000);
v(:, 1) = [vR0; vC0];
accurate_h = 1e-5;
inaccurate_h = 1e-3;
for k = 1:999
    v(:,k+1) = [0 -(1-(accurate_h/(R*C))); 0 (1-(accurate_h/(R*C)))]*v(:,k) + [accurate_h/(R*C)-1; accurate_h/(R*C)]*Vin(k);
end

t = 0:1e-6:0.1;
figure();
hold on;
plot(t,1-exp(-t/(R*C))); % Gives you the real function to compare against our C values
plot(accurate_h.*(1:k+1), v(2,:));

v = zeros(2, 1000);
v(:, 1) = [vR0; vC0];
for k = 1:999
    v(:,k+1) = [0 -(1-(inaccurate_h/(R*C))); 0 (1-(inaccurate_h/(R*C)))]*v(:,k) + [inaccurate_h/(R*C)-1; inaccurate_h/(R*C)]*Vin(k);
end

plot(inaccurate_h.*(1:k+1), v(2,:));
hold off;
xlabel('Time (s)');
xlim([0,5e-3]);
ylabel('Voltage (V)');
legend('Accurate Vc when h = 1e-5', 'Expected Vc', 'Inaccurate Vc when h = 1e-3');
title('Accurate, Expected, and Inaccurate Voltage Across Capacitor');
