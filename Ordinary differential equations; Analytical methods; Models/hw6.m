% homework 6 
% m^3/yr for the DE so multiply by area
% m/yr for plotting the individual parameters/dynamics
% solve for S
% put everything on right side of equation in m^3/yr
% use Euler forward

dt = 1/365; % 1 day time step
t = [0:dt:1000]; % 1 year for question 1 and 1000 yrs for question 3
% 50 yrs for questions 4,5,6

% % Precipitation P
 Pmax = 1; % m/yr
 P = (Pmax/2)*(cos(2*pi*t)+1);
% 
% % plot P
 %figure(1)
 %plot(t,P)
 %title('Precipitation')
% 
% % Temperature T
 Tmax = 25; % deg C
 Tmin = 10; % deg C
 T = ((Tmax-Tmin)/2)*(sin(2*pi*t-pi/2)+1)+Tmin;
% 
% % plot T
% %figure(2)
% %plot(t,T)
% %title('Temperature')
% 
% % Runoff qs
 ks = 10; % permeability of the ground
 Ph = 1; % m/yr
 qs = P./(1+ks*exp(-P/Ph)); % runoff (m/yr)

% plot qs
%figure(3)
%plot(P,qs./P)
%title('Fraction of precip entering runoff')

%% Question 1
% find equation for E as a functin of T
kT = 0.1/100;

E = (1/2)*kT*T.^2;

nt = length(t);
Pmid = 0.5*(P(2:nt)+P(1:nt-1));
Pint = Pmid./dt;
Ptot = sum(Pint);

% total precipitation is integral of P with respect to dt
% same for evaporation

%% Question 2

figure(1)
plot(t,P,'-ob')
hold on
plot(t,E,'-or')
title('Precipitation and Evapotranspiration')
xlabel('time')
ylabel('moisture flux (m/yr)')

% months labels
dd = [ 31 28 31 30 31 30 31 31 30 31 31];

% plot something
set(gca,'XTick',cumsum(dd)./365)
set(gca,'XTickLabel',{'Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec','Jan'})

%% Question 3
% without grounwater pumping find steady state solution 
% to S(t) given S(t=0) = 10^6 m^3

% set inital conditions
Pmax = 1; %m/yr
Tmax = 25; % degrees Celsius
Tmin = 10;

A = 10^6; % m^2
kb = 0.01;
ks = 10;
Ph = 1; % m/yr
qn = 0;

% differential equation (model/function)

% solver with Euler forward
S = 0*t; % placeholder
S0 = 10^6; % m^3
S(1) = S0; % initial condition
for i = 2:length(t)
    P(i-1) = (Pmax/2)*(cos(2*pi*t(i-1))+1);
    T(i-1) = ((Tmax-Tmin)/2)*(sin(2*pi*t(i-1)-pi/2)+1)+Tmin;
    E(i-1) = (1/2)*kT*T(i-1).^2;
    qs(i-1) = P(i-1)./(1+ks*exp(-P(i-1)/Ph));
    S(i) = S(i-1) + dt*(P(i-1)*A - E(i-1)*A - qs(i-1)*A - kb*S(i-1));
end

figure(2)
plot(t,S,'-ob')
hold on
