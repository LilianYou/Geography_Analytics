clear;

x(1) = 5;
y(1) = 5;

alpha = 1.0;
beta = 1.0;
gamma = 1.0;
delta = 1.0;

dt = 0.01;

for t = 2:5000
    dx = x(t-1) * (alpha - beta * y(t-1));
    dy = - y(t-1) * (gamma - delta * x(t-1));
    x(t) = x(t-1) + dt*dx;
    y(t) = y(t-1) + dt*dy;
end

plot(x, 'r');
hold on;
plot(y, 'g');

%plot(x,y);

%%1 
% 1) plot the changes of x and y against time
figure(1)
plot(diff(x), 'r');
hold on;
plot(diff(y), 'g');


% 2) a phase plot between changes of x and y
figure(2)
plot(diff(x), diff(y));
title('Changes of x and y')

%%2 I think the reason for population increase is because of natural
%%selection that the prey and predators with stronger surviving ability
%%lives longer and pass their gene with strong surviving characteristics to
%%offsprings so their offsprings live longer and longer.



