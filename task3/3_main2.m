clear;
clc;
d = 0.8;
l = 1;
X1 = 3.6;
X2 = 0;
Y1 = 0.8;
Y2 = -2.4;
mu1 = 0.525;
mu2 = 2.85;
eps = 0.1;
k = 1;
nu = 1;
x10 = 0;
dx10 = 10;
x20 = -0.65;
dx20 = 10;
ddelta0 = 0;
delta0 = 0.03;
ddelta0 = 0;
syms delta1 delta2 real;

sigma1 = sign(dx10);
sigma2 = sign(dx20);
phi0=asin(d/(l+delta0));
Xs = (X1 - X2) / cos(phi0);
Y1s = Y1 / sin(phi0);
Y2s = Y2 / sin(phi0);
mu1s = mu1 * tan(phi0);
mu2s = mu2 * tan(phi0);

R=k*delta1/eps^2+nu*delta2/eps;
Phi= 2 * R + sigma1 * mu1s * abs(R - Y1s) - sigma2 * mu2s * abs(R + Y2s);
ddelta2 = cos(phi0)^2*(Xs-Phi);

a_21=diff(ddelta2,delta1);
a_22=diff(ddelta2,delta2);

ddelta2=subs(ddelta2,delta2,0);
delta1_n = solve(ddelta2);
delta1_n = double(delta1_n);
study_and_draw(a_21,a_22,delta1,delta2,delta1_n(1));
study_and_draw(a_21,a_22,delta1,delta2,delta1_n(2));
