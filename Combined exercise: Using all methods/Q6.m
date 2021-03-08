% (a) y = ym - C.*exp(-kt)
%(b)
k = 1/2;
ym = 10;
% time domain
dt = 0.1;
t = [0:dt:10];

% differential equation
f = @(t,y)k.*(ym-y);

% initial condition
y0 = 1;

% solve with Euler forward
yf = 0*t; % placeholder
yf(1) = y0;

for i = 2:length(t)
    yf(i) = yf(i-1) + dt*f(t(i-1),yf(i-1));
end

% plot
plot(t,yf,'-og')
hold on
xlabel('t')
ylabel('y')

% (ii) solve with euler backward
yb = 0*t; %placeholder
yb(1)= y0;
for i = 2:length(t)
    yb(i)=(yb(i-1)+dt*k*ym)./(1+dt*k);
end;

%plot
plot(t,yb,'-<m')

% (iii) mid-point Euler backward
yg = 0*t; %placeholder
yg(1)= y0;
for i = 2:length(t)
    % yg(i) = yg(i-1) +
    % dt*f(t(i-1)+0.5*dt,yg(i-1)+0.5*dt*f(t(i-1),yg(i-1)))
    yg(i)= (1-dt*k+0.5*(dt.^2)*(k.^2))*yg(i-1) + dt*k*ym*(1+0.5*dt*k);
end;

%plot
plot(t,yg,'bd')
% (c) y = ym - C.*exp(-kt), k = 1/2; ym = 10; t=0, y=1; 1 = 10-C, C = 9; 

yh = 10 - 9*exp(-0.5*t);
plot(t,yh,'*');
legend('Euler forward','Euler backward','mid point method','analytical method');