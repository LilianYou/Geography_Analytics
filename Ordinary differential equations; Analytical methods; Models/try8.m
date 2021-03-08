dt = 1/365;
t1 = [0:dt:600];
t2 = [0:dt:605];

qn = 0;
kb = 0.01; % /yr
ks = 10;
kT = 0.001; % m/yr
Ph = 1; % m/yr
A = 10.^6; % m.^2
Tmax = 25; % C
Tmin = 10; % C

Pmax = 1; %m/yr
Pmaxd = 0.25; 

S = 0*t1;
S0 = 10.^6; % m.^3
S(1) = S0; %S = P - E - qs - qn - qb; % steady-state
for i = 2:length(t1)
    P(i-1) = (Pmax/2)*(cos(2*pi*t1(i-1))+1);
    T(i-1) = ((Tmax-Tmin)/2)*(sin(2*pi*t1(i-1)-pi/2)+1)+Tmin;
    E(i-1) = (1/2)*kT*T(i-1).^2;
    qs(i-1) = P(i-1)./(1+ks*exp(-P(i-1)/Ph));
    S(i) = S(i-1) + dt*(P(i-1)*A - E(i-1)*A - qs(i-1)*A - kb*S(i-1));
end


for i = 219001:length(t2)
    P(i-1) = (Pmaxd/2)*(cos(2*pi*t2(i-1))+1);
    T(i-1) = ((Tmax-Tmin)/2)*(sin(2*pi*t2(i-1)-pi/2)+1)+Tmin;
    E(i-1) = (1/2)*kT*T(i-1).^2;
    qs(i-1) = P(i-1)./(1+ks*exp(-P(i-1)/Ph));
    S(i) = S(i-1) + dt*(P(i-1)*A - E(i-1)*A - qs(i-1)*A - kb*S(i-1));
end

figure(8)
plot(t2((600/dt):(605/dt)), S((600/dt):(605/dt))/A);
xlabel('Time(year)');
ylabel('Water Storage (m.^3)');
title('Water Storage Over Five Years');

drop = (S(605/dt)-S(600/dt))/A; % drop = -1.4587

%% 9
% it also depends on the region and soil, plants do help a lot with water
% storage