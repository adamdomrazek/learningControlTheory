close;
clear;
clc;

s = tf("s");

a = 1;
z = 0.2;
w = 5;

H = @(a) ((s/(a*z*w)) + 1 )/( (s/w)^2 + 2*z*(s/w) + 1 );

figure();
hold on;
for i=-5:5
    step(H(i));
end