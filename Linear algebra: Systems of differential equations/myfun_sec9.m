function [F,J] = myfun_sec9(v,A,r)

% F = A*v + q(v) - r

% non-linear terms
x = v(1);
y = v(2);
q = [-2*x*y 4*x*y]';

% evaluate functions
F = A*v + q - r;

% evaluate Jacobian: J = A + dq/dv
dqdv = [-2*y -2*x; 4*y 4*x];
J = A + dqdv;