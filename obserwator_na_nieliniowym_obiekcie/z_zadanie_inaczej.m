%%
clear
close 

%%
S  = 1;
K  = 0.02; 
c1 = 1;
c2 = 2;

%%
A = [ -0.01, 0; 0, -0.02];
B = [1, 1; -0.25, 0.75];
C = eye(2);
E = [0.01, 0; 0, 1];

% macierze systemu rozszerzonego
Aa = [A, zeros(2);
      E, zeros(2)];
Ba = [1, 1;
      -0.25, 0.75;
      zeros(2)];
Ca = [C, zeros(2)];
Ea = [E zeros(2)];

%% LQR
Q=diag([0.1 5 30 0.1]);
R=diag([10 10]);

N=0;

%% Obliczanie LQR
% najpierw zrobiliśmy na piechotę przez lqr ale jest do tego dedykowana funkcja lqi

% % System rozszerzony
% sys = ss(Aa, Ba, Ea, [0]);
% [Fa,Sa,Pa] = lqr(sys, Q, R, N);

% system nierozszerzony - lqi zakłada trochę inną strukturę sterowania,
% dlatego wzmocnienia dla zm. całkowych wychodzą z innym znakiem
sys = ss(A, B, E, [0]);
[Fa,Sa,Pa] = lqi(sys, Q, R, N);


%% macierze do simulinka
F = Fa(:, 1:2)
M = Fa(:, 3:4)


%% bieduny zamkniętego
scatter(real(Pa), imag(Pa), 100, 'x', 'LineWidth', 3)
grid on;

disp(Pa)

%% Bieguny obserwatora wybieramy w zależności od położenia biegunów całęgo sys. rozsz.
% wybrane
clc
po1 = -5;
po2 = -6;

syms s g11 g12 g21 g22

chr = (s-po1)*(s-po2);
chr = expand(chr);

disp("pożądany wiel. chr.")
disp(chr)

% wzmocnienia obserwatora
% G = [g11, g12;
%      g21, g22];

G = [g11, 0;
     0, g22];

% a taki mam
dupa = det( s*eye(2) - (A-G*C) );
dupa = collect(dupa, s);


disp("wiel. char. obs.")
disp(dupa)

wspolczynniki = coeffs(dupa, s)

% Trzeba rozwizać
% (g11 + g22 + 0.0300) = 11
% 2.0000e-04*(50*g22 + 1)*(100*g11 + 1) = 30
eq1 = g11 + g22 + 0.0300 == 11
eq2 = 2.0000e-04*(50*g22 + 1)*(100*g11 + 1) == 30
ans_g11 = solve(eq1, g11)
ans_g22 = solve(eq2, g22)
 
equation_na_g22 = ans_g22
equation_na_g11 = ans_g11 == g11

% subs([symb expr], [old], [new])
equation_na_g11 = subs(equation_na_g11, g22, equation_na_g22)
solve(equation_na_g11, g11);

wynika_na_g11 = solve(equation_na_g11, g11);

wynika_na_g11_number_1 = wynika_na_g11(1)
wynika_na_g11_number_2 = wynika_na_g11(2)

wynika_na_g22_number_1 = subs(equation_na_g22, g11, wynika_na_g11_number_1)
wynika_na_g22_number_2 = subs(equation_na_g22, g11, wynika_na_g11_number_2)


G1 = diag([wynika_na_g11_number_1 , wynika_na_g22_number_1])
G2 = diag([wynika_na_g11_number_2 , wynika_na_g22_number_2])

% Bo G1 i G2 są symbolicznie
G1 = double(G1);
G2 = double(G2);

%% ===============================================================
% symulacja
sim("z_MODEL_nieliniowy.slx")
%% ===============================================================




















%% gowno nie działa
% tFinal = 20;
% step   = 0.001;
% x0 = [0;
%       0.1;
%       0;
%       0];
% t = 0:step:tFinal;
% 
% % system zamknięty sprz. całk. plus od stanu, zapis na systemie
% % rozszerzonym
% sys = ss((Aa - Ba*Fa), zeros(4), Ea, [0]);
% [ya, t, xa] = initial(sys, x0, t);
% 
% % trajektorie stanu sys. rozsz.
% x1 = xa(:, 1);
% x2 = xa(:, 2);
% xi1 = xa(:, 3);
% xi2 = xa(:, 4);
% 
% % Wyjście sterowane
% f = Ea * xa.';
% f = f.';
% 
% f1 = f(:, 1);
% f2 = f(:, 2);
% 
% % Sprawdzenie regulatora na zlinear. systemie
% % Trajektorie stanu
% subplot(3, 2, 1);
% plot(t, x1);
% title("stan \Deltah = \Deltax_1")
% grid on;
% 
% subplot(3, 2, 2);
% plot(t, x2);
% title("stan \Deltah = \Deltax_2")
% grid on;
% 
% subplot(3, 2, 3);
% plot(t, f1);
% title("stan \Deltac = \Deltaf_1")
% grid on;
% 
% subplot(3, 2, 4);
% plot(t, f2);
% title("stan \Deltac = \Deltaf_2")
% grid on;
% 
% 
% % Sygnał sterujący: u = -Fx, bo f_zadane = 0 => u_zadane=0
% u = -Fa * xa.';
% u = u.';
% u1 = u(:, 1);
% u2 = u(:, 2);
% 
% subplot(3, 2, 5);
% plot(t, u1);
% title("\Deltau_1 = \DeltaF_1")
% grid on;
% 
% subplot(3, 2, 6);
% plot(t, u2);
% title("\Deltau_2 = \DeltaF_2")
% grid on;
