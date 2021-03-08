function [F,J] = myfunc_q7(v, A, r)
A1 = 0.2;
P = 0.1;
Q = 0.1;
B = 0.3;
R = 0.2;
S = 0.1;
C = 5;
D = 10;

x = v(1);
y = v(2);

q = [-(P.*(x.^2) + Q.*x.*y);-(R*x.*y + S.*(y.^2))];
F = A*v + q +r;

dqdv = [(-2.*P.*x-Q.*y),(-Q.*x); (-R.*y) , (-R.*x - 2.*S.*y)];
J = A + dqdv;
