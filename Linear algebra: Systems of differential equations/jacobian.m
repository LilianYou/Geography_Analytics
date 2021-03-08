function [F,J] = jacobian(v, A, r)
qp = 1/2;
qc = 1/5;
kR = 2;
kN = 1/10;
a = 1/3;
S = 1/20;
w = 1/5;

N = v(1);
P = v(2);
C = v(3);
q = [- kR*(N./(N+kN));kR*(N./(N+kN)) - a.*P.*C;a.*P.*C];
F = A*v + q +r;

dqdv = [-kR*kN*((N+kN).^(-2)),0,0; kR*kN*((N+kN).^(-2)), -a*C,-a*P;0,a*C,a*P];
J = A + dqdv;