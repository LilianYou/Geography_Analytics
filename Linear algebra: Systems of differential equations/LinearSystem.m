% first, create the matrix of coefficients anad the right-hand side vector
A = [2, 3; 5, 7]; % commas separate columns and semi-columns separate rows
r = [1;3]; % two rows (column vector: 2*1)
% use backslash operator to get the matrix inverse times a vector
v = A\r; % V = a inverse times r
% NOTE: DO NOT use inv(A)
v2 = inv(A)*r;

% try the following
% solve: 
% 2x + y -3z = 5
% 3x -2y + 2z =5
% 5x -3y -z = 16

% Another
% 2x + 3y - 2x = 5
% x - 2y + 3z = 2
% 4x - y + 4z = 1

A1 = [2, 1, -3; 3, -2, 2; 5, -3, -1];
r1 = [5; 5; 16];
v1 = A1\r1;

A2 = [2, 3, -2; 1, -2, 3; 4, -1, 4];
r2 = [5; 2; 1];
v2 = A2\r2;

% acos(-9/sqrt(420)*180/pi
