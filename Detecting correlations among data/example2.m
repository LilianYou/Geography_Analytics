N = 200;
x = [0:100]/20;
f = ones(1,101)*1/2;
ff= zeros(1,101);
for i = 1:2:N
    a = 2/pi/i;
f = f+ a*sin(2*pi*i*x);

end

figure(8)
plot(x,f)
title('First 100 Sine Terms')