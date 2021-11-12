%%
h = 1e-05;
R = 1e3;
C = 1e-6;
vC0 = 0;
vR0 = 0;

vin = ones(1,1000); 
v = zeros(2,1000); % These are our states
v(:,1) = [vR0; vC0]; % Our states are vR and vC, so they can be put into a matrix

for k=1:999
    v(:,k+1) = [0 -(1-(h/(R*C))); 0 (1-(h/(R*C)))]*v(:,k) + [h/(R*C)-1; h/(R*C)]*vin(k);
end

t = 0:1e-6:0.1;
figure;
plot(h.*(1:k+1),v(2,:));
hold on;
t = 0:1e-6:0.1;
plot(t,1-exp(-t/(R*C))); % Gives you the real function to compare against our C values
xlabel('Time (s)');
xlim([0,5e-3]);
ylabel('v_C (V)');
title('Voltage across Capacitor');

Vout = Vin;

legend('Vc','Vc_r');
