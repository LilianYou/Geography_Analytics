% (a)
t = [0:0.1:10];
x = exp(t./2).*sin(2.*t);
y = exp(t./5).*cos(2.*t);
figure(1)
plot(x,y,'-o')
xlabel('x')
ylabel('y')
title('Position (x,y) Over Time Domain t')
grid on
grid minor
