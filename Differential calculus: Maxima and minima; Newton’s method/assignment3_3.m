%% Problem 2 flux of organic carbon at various depths in the ocean
% a
depth = [100, 250,650,1000,1800, 2350,3500,5000];%depth (m)
flux = [5.8166, 2.4736, 1.4481, 1.0013, 0.2982, 0.4126, 0.2739, 0.2897];%(mgC/m^2/d)
figure(2);
plot(flux, depth, '-');
xlabel('organic carbon flux (mgC/m^2/d)');
ylabel('negative depth (m)');
title('flux of organic carbon at various depths in the ocean');
% b
Zo = 100;
Z = depth;
yobs = flux;
F(Zo)=5.8166;
f = @(b)(5.8166.*(Z/100).^(-b));

initial_guess = 0.1;
b = initial_guess;

y = f(b); %call function to evaluate initial value
itc = 0; %iteration counter

cost = @(b)(sum(y(b)-yobs).^2);

c = cost(b);

% the derivative of the cost function
db = 1e-3;
cup = cost(b+db);
cdown = cost(b-db);
cprime = (cup-cdown)/(2*db);

% equation has two roots x1 = 1.5059, y1 = 0.0023; x2 = 2.0909, y2 =
% 0.0015.
%figure(1);
%plot(xi,yi,'o')
%title('iteration values for f(x) = exp(x)-x-3')