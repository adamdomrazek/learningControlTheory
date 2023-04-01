clc;
clear all;

%% obiekty
s = tf('s');

reg = 5;
go = (s+20)/(s^2+2*s+1);


go
disp(go);

go_ss = ss(go);
reg_ss = ss(reg);

G_open = series(go_ss, reg_ss);
G_closed = feedback(G_open, 1, -1);
% do spr. # wejsc i wyjs -> size(Go)

%% sygnał
Ts = 0.01; 
tt = -5:Ts:20;    % support sygnału

y1 = ramp(tt,3,3);
y2 = ramp(tt,-6,1);
y3 = ramp(tt,3,0);
y4 = -3 * ustep(tt,-3);
u = y1+y2+y3+y4;

%% symulacja
x0 = [0, 0];
y = lsim(G_closed, u, tt, x0);

figure(1);
hold on;
grid on;
plot(tt, u);
plot(tt, y);
hold off;










