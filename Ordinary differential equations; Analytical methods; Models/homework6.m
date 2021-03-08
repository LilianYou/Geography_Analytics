%% question1

%T = ((T_max - T_min)./2).*(sin(2*pi*t - pi*(1./2))+1)+T_min;
%dE./dT = kT.*T;
%E = kT.*(1./2).*(T.^2); % T: 0 C = 0 cm/yr

%% question2
dt = 1/365;% over the course of one year
t = [0:dt:1];
kT = 0.1; % cm.* yr.^(-1).*C.^(-2)
Pmax = 100; % cm/yr
Tmax = 25; % C
Tmin = 10; % C
T = ((Tmax - Tmin)./2).*(sin(2*pi*t - pi*(1./2))+1)+Tmin;
% (a)
P = (Pmax./2).*(cos(2*pi*t)+1);
E = kT.*(1./2).*(T.^2);
figure(1);
plot(t,P);
hold on
plot(t,E);
legend('Precipitation','Evapotranspiration');
xlabel('time(year)');
ylabel('moisture flux (cm/yr)');
title('amount of water stored in the aquifer');
% (b)
nt = length(t);
P_int = sum(P(2:nt).*dt); % P_int = 50
% (c)
% months labels
dd = [ 31 28 31 30 31 30 31 31 30 31 31];

% plot something
set(gca,'XTick',cumsum(dd)./365)
set(gca,'XTickLabel',{'Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec','Jan'})

% net evaporation: during May and September

%% 3 
dt = 1;
t = [0:dt:1000];
qn = 0;
kb = 0.01; % /yr
ks = 10;
kT = 0.001; % m/yr
Ph = 0.01; % m/yr
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

