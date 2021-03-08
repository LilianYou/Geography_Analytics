%% 3 
dt = 1/365;
t = [0:dt:1000];
qn = 0;
kb = 0.01; % /yr
ks = 10;
kT = 0.001; % m/yr
Ph = 1; % m/yr
A = 10.^6; % m.^2
Tmax = 25; % C
Tmin = 10; % C
T = ((Tmax - Tmin)./2).*(sin(2*pi*t - pi*(1./2))+1)+Tmin;
Pmax = 1; %m/yr
P = (Pmax./2).*(cos(2*pi*t)+1);
E = kT.*(1./2).*(T.^2);
qs = P/(1+ks*exp(-P/Ph));

%qb = kb*S;

% a
% differential equation

S = 0*t;
S0 = 10.^6; % m.^3
S(1) = S0; %S = P - E - qs - qn - qb; % steady-state
for i = 2:length(t)
    P(i-1) = (Pmax/2)*(cos(2*pi*t(i-1))+1);
    T(i-1) = ((Tmax-Tmin)/2)*(sin(2*pi*t(i-1)-pi/2)+1)+Tmin;
    E(i-1) = (1/2)*kT*T(i-1).^2;
    qs(i-1) = P(i-1)./(1+ks*exp(-P(i-1)/Ph));
    S(i) = S(i-1) + dt*(P(i-1)*A - E(i-1)*A - qs(i-1)*A - kb*S(i-1));
end

% b
figure(2)
plot(t, S, '-ob')
xlabel('time(year)');
ylabel('water storage (m.^3)');
title('Water Storage Over One Thousand Years');

figure(3);
plot(t((600/dt):(605/dt)),S((600/dt):(605/dt)))
xlabel('Time(year)');
ylabel('Water Storage (m.^3)');
title('Water Storage Over Five Years');
% March

% c
% spring 2.434 - 2.443; summer 2.443 - 2.434; fall 2.426 - 2.434; winter
% 2.434 - 2. 426
depth = 0.5*(S(605/dt)+S(600/dt))/A;  % depth = 0.0028


