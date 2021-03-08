%(a)
t_r = [0, 100, 200, 300, 400, 500, 600, 700, 800, 900, 1000]; % unit yrs
A_r = [535, 390, 235, 166, 108, 65, 47, 28, 22, 12, 8]; % unit g

P = polyfit(t_r,log(A_r),1);
% k = -0.0042  In(A0) = 6.3393 A0 = 566.3997 

%(b)
%A = 566.3997.*exp(-0.0042.*t);
% as k<0, this is an exponential decay model.
A(t2)/A(t1) = 1/2;
(566.3997.*exp(-0.0042.*t2))./(566.3997.*exp(-0.0042.*t1))= 1/2
t2-t1 = log(1/2)./(-0.0042)= 165.0350;
t = [0:1:2000];
A = 566.3997.*exp(-0.0042.*t);
figure(1)
plot(t,A)
hold on
plot(t_r,A_r,'o')
grid on
grid minor
legend('Model','Hypothetical Data')
xlabel('Time(yrs)')
ylabel('Amount of a Radioactive Element(g)')
title('Amount of a Radioactive Element Change Over Time')
% material remaining after 2000 years
M = 566.3997.*exp(-0.0042.*2000);
% 0.1274

% (c) evaluate analytically
A = 566.3997.*exp(-0.0042.*t);
dA/dt = 566.3997.*(-0.0042).*exp(-0.0042.*t)= -2.3789.*exp(-0.0042.*t);
int(A) = (566.3997./(-0.0042)).*exp(-0.0042.*t)= -134860.*exp(-0.0042.*t)+C;
t=0, int(A)=535, C = 135395
int(A) = -134860.*exp(-0.0042.*t)+135395
% (d) evaluate numerically dA/dt
nt = length(t_r);
dt = t_r(2:nt)-t_r(1:nt-1);
dA = A_r(2:nt)-A_r(1:nt-1);
dAdt = dA./dt;
tmid = .5*(t_r(2:nt)+t_r(1:nt-1));
dAAdt = -2.3789.*exp(-0.0042.*tmid);% evaluate analytically
figure(2)
plot(tmid,dAdt,'o-')
hold on
plot(tmid,dAAdt,'rd-')
legend('dA/dt numerically','dA/dt analytically')
xlabel('Time(yrs)')
ylabel('dA/dt')
title('dA/dt Over Time')

%(e)
% analytical int
dx =100;
b = 1000;
xb = [0:dx:b];
nxb = length(xb);
xbmid =.5*(xb(1:nxb-1)+xb(2:nxb));
yba_int = -134860.*exp(-0.0042.*xb)+135395;
ybamid_int = -134860.*exp(-0.0042.*xbmid)+135395;

% numerical int
A_r = [535, 390, 235, 166, 108, 65, 47, 28, 22, 12, 8]; % unit g
yn_int = cumsum(A_r(2:end).*dx);
figure(3)
plot(xbmid,ybamid_int,'o-')
hold on
plot(xb(2:end),yn_int,'+-')
legend('Analytical Int','Numerical Int')
xlabel('Time')
ylabel('Integration')
title('Integration Over Time')
