%%
clc
%%
clear all;

%% Stałe
% J - m. bezw. wału silnika
% masa obciążenia mL, rL, promień koła obiązenia
Km = 0.0257;     % [V/(rad*sek)]
Rm = 2.675;      % [Ohm]
J  = 9.63e-6;    % [kg*m^2]
mL = 0.033;      % [kg]
rL = 0.0262;     % [m]
JL = mL * rL^2;
Jeq= JL + J;


%% Biały szum pomiarowy
Psz = 0.005;
fsz = 2500;

%% Nastawy regulatora PID prędkości
Kp_v = 0.04604;
Ti_v = 0.17;
Td_v = 0; 
K_windup_v = 3;

%% Nastawy regulatora PID położenia
Kp_p = 2;
Td_p = 0; 
K_windup_p = 1;

%%
w_filtr_pom = 1/10;


%% Symulacja
% sout = sim("M1_regPREDKOSCI_2020b.slx");
% sout = sim("M2_regPOLOZENIA_2020b.slx");
% sout = sim("M3_regOBA_2020b.slx");







%%
% tout = sout.simout.Time;
% simdata = sout.simout.Data;
% uP = simdata(:,1);
% uD = simdata(:,2);
% uI = simdata(:,3);
% u  = simdata(:,4);
% zadana = simdata(:,5);
% omega_w = simdata(:,6);
% zaszumiony_omega_w = simdata(:,7);


% %% Nastawy regulatora PID prędkości
% Kp_v = 0.04304;
% Ti_v = 0.17;
% Td_v = 0; 
% K_windup_v = 3;
% 
% %% Nastawy regulatora PID położenia
% Kp_p = 11;
% Ti_p = 0.66;
% Td_p = 0; 
% K_windup_p = 3;