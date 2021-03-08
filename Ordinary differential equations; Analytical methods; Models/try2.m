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

kn = 10000; % m.^3/yr

t3 = [600:dt:650];

qn = 0*t;
qn0 = 0; % m.^3
qn(1) = qn0; %S = P - E - qs - qn - qb; % steady-state

%for j = 2:length(t3)
for j = 2:length(t)
    qn(j) = qn(j-1)+ kn*dt;
end

for i = 2:length(t3)
    Sd(i)= S((600/dt)+i)-qn((600/dt)+i);
end

figure(5)
plot(t3,Sd);
drop = (Sd(length(t3))-Sd(2))/A;%-0.4785
figure(6)
plot(t3,Sd/A);

%% 6 
kn = qn/S;
