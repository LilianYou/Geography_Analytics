% integration
dx =1;
b = 5;
a =2;
xb = [0:dx:b];
xa = [0:dx:a];
nxb = length(xb);
nxa = length(xa);

xbmid =.5*(xb(1:nxb-1)+xb(2:nxb));


ya = exp(xa);
yb = exp(xb);
ybmid = exp(xbmid);

% plot 
%figure(2)
% plot('x,y,'o-');

% integral
y_int_0_b = sum(yb(2:nxb).^dx); % integral from 0 to b
y_int_0_a = sum(ya(2:nxa).^dx); % integral from 0 to a
y_int_a_b = y_int_0_b - y_int_0_a; % integral from a to b

% plot 
figure(2)
plot(xb,yb)
hold on
y_int = cumsum(yb(2:end).^dx);
plot(xb(2:end),y_int)
