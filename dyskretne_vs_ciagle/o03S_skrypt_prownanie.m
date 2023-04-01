%%
clc
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

%% Nastawy regulatora PID
Kp = 0.04;
Ti = 0.11;
Td = 0.009; 
K_windup = 3;

w_filtr = 10;

fs = 30;
Ts = 1/fs;

calka_on_off = 1; % do włączanie i wyłączania całki


%%
syms s z K_p T_i T_d T_s omega_filtr H(s) H(z)


%% FILTR FILTR FILTR FILTR 
%% Transmitancja do dyskretyzacji, metoda Eulera wstecz 
H(s) = 1 / (omega_filtr^(-1)* s + 1);

disp(H(s)) 
[nc, dc] = numden(H(s));

%% podstawienie metoda tustina (/trapezów/biliniowa)
k = (1-z^(-1)) / T_s
H(z) = subs(H(s), s, k);

disp(H(z));
[nd, dd] = numden(H(z));
HH = collect(H(z), z)
[nd, dd] = numden(HH)

disp('LICZNIK: ')
collect(nd, z)
disp('MIANOWNIK: ')
collect(dd, z)

HH = subs(HH, T_s, Ts);
HH = subs(HH, omega_filtr, w_filtr);

disp('=================================')
HH = simplify(HH)
disp('=================================')
[n, d] = numden(HH)

num_f_e   = sym2poly(n)
den_f_e   = sym2poly(d)

%% Symulacja
sout = sim("o03M_POROWNANIE_CIAGLY_DYSKRETNY_EULER.slx");
