%%
clc
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

%% najpierw zrobiliśmy na piechotę przez lqr ale jest do tego dedykowana funkcja lqi

% % System rozszerzony
% sys = ss(Aa, Ba, Ea, [0]);
% [Fa,Sa,Pa] = lqr(sys, Q, R, N);

% system nierozszerzony
sys = ss(A, B, E, [0]);
[Fa,Sa,Pa] = lqi(sys, Q, R, N);

%%
x0 = [0.05;
      0.05;
      0;
      0];
t = 0:0.01:8;

sys = ss((Aa - Ba*Fa), Ba, Ca, [0]);
[ya, t, xa] = initial(sys, x0, t);

x1 = xa(:, 1);
x2 = xa(:, 2);
xi1 = xa(:, 3);
xi2 = xa(:, 4);

f = Ea * xa.';
f = f.';

f1 = f(:, 1);
f2 = f(:, 2);


%% macierze do simulinka
F = Fa(:, 1:2)
M = Fa(:, 3:4)

%% symulacja
sim("MODEL_nieliniowy_prevprevprev.slx")


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


% % Sygnał sterujący: u = -Fx, bo f_zadane = 0 => u_zadane=0
% u = -Fa * xa.';
% u = u.';
% u1 = u(:, 1);
% u2 = u(:, 2);

% subplot(3, 2, 5);
% plot(t, u1);
% title("\Deltau_1 = \DeltaF_1")
% grid on;
% 
% subplot(3, 2, 6);
% plot(t, u2);
% title("\Deltau_2 = \DeltaF_2")
% grid on;
