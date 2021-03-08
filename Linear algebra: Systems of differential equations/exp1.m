% system of differential equation
% dv/dt = A*v
%
% coeffiencts of A
P = 0.5;
Q = 2;
R = -1;
S = 0.5;

% matrix A
A = [P Q;R S];

% initial guess
v0 = [1 -1]';

% time domain
dt = .01;
t = [0:dt:10];
v = zeros(2,length(t)); % placeholder for solution
v(:,1) = v0; % initial guess
for i = 2:length(t)
    v(:,i) = v(:,i-1)+dt*A*v(:,i-1); % EF
end

% plot 
figure(4)
plot(t,v')