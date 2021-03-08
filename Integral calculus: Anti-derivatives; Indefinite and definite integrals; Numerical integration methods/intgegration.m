% integration
dx = 1;
x =[0:dx:5];
dx = length(x);
y = exp(x);

%plot
figure(1)
%plot(x,y,'o -')

% integral
y_int_0_5 = sum(y(2:nx).*dx); % integral from 0 to 5
