% euler method

% time domain
dt = 0.1;
t = [0:dt:10];

% differential equation
f = @(t,y)cos(t).*y;

% initial condition
y0 = 5;

% solve with Euler forward
yf = 0*t; % placeholder
yf(1) = y0;

for i = 2:length(t)
    yf(i) = yf(i-1) + dt*f(t(i-1),yf(i-1));
end

% plot
plot(t,yf,'-ob')
hold on
xlabel('t')
ylabel('y')
% solve with euler backward
yb = 0*t; %placeholder
yb(1)= y0;
for i = 2:length(t)
    yb(i)=yb(i-1)./(1-dt*cos(t(i)));
end;

%plot
plot(t,yb,'-<m')
