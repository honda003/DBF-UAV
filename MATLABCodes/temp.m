clc 
close all
clear all

MTOW = 1.7 * 9.8;
V_cruise=22;
Sw = 0.2872;
AR=7;

MAC = 0.2026;

rho = 1.225;  

meu = 1.5e-5; 

V_max = 1.3 * 22;

Re_max = V_max * MAC / meu;

Re_cruise = V_cruise * MAC / meu;

Cf = 1.328 / sqrt(Re_cruise);

tc_W = 12/100;
XCm_W = 29.03/100;

tc_t = 7/100;
XCm_t = 29.03/100;

FF_W = 1 + (0.6 / XCm_W) * tc_W + 100 * tc_W^4;
FF_t = 2 * (1 + (0.6 / XCm_t) * tc_t + 100 * tc_t^4);

FF = FF_W + FF_t;

Swet_W = 2 * (1 + 0.2 * tc_W) * Sw;
Swet_t = 2 * (1 + 0.2 * tc_t) * (0.136030131 + 0.095221091);

Swet = Swet_W + Swet_t;

Cdo = Cf * FF * Swet / Sw;
W_per_S = MTOW / Sw;
e = 0.8;
K = 1 / (pi * e * AR);

T = MTOW * ( (rho * V_cruise ^ 2 * Cdo * (0.5 / W_per_S)) + ((2 * K * W_per_S) / (rho * V_cruise ^ 2)) )
