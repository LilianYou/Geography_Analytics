dt = 1/365;
t = [0:dt:1000];
kn = 0;
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


S = 0*t;
S0 = 10.^6; % m.^3
S(1) = S0; %S = P - E - qs - qn - qb; % steady-state
for i = 2:length(t)
    P(i-1) = (Pmax/2)*(cos(2*pi*t(i-1))+1);
    T(i-1) = ((Tmax-Tmin)/2)*(sin(2*pi*t(i-1)-pi/2)+1)+Tmin;
    E(i-1) = (1/2)*kT*T(i-1).^2;
    qs(i-1) = P(i-1)./(1+ks*exp(-P(i-1)/Ph));
    S(i) = S(i-1) + dt*(P(i-1)*A - E(i-1)*A - qs(i-1)*A - kb*S(i-1)- kn*S(i-1));
end

%kn = qn/S;

kn = (P(600/dt)*A - E(600/dt)*A - qs(600/dt)*A - kb*S(600/dt))/S(600/dt);

% kn = 0.0202;

