clc;
clearvars;
close all;


R = 100;
L = 0.1;
C = 1e-6;
h = 1/192000;
vC0 = 0;

Vin = ones(1, 1000);
i = zeros(1, 1000);

