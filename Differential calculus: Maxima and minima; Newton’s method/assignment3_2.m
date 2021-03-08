%% Problem 2 flux of organic carbon at various depths in the ocean
% a
depth = [100, 250,650,1000,1800, 2350,3500,5000];%depth (m)
flux = [5.8166, 2.4736, 1.4481, 1.0013, 0.2982, 0.4126, 0.2739, 0.2897];%(mgC/m^2/d)
figure(2);
plot(flux, depth, '-');
xlabel('organic carbon flux (mgC/m^2/d)');
ylabel('negative depth (m)');
title('flux of organic carbon at various depths in the ocean');
% b
Zo = 100;
F(Zo) = 5.8166;
b = 0.8333;
x = [0:50:5000];
y = F(Zo).*((x/Zo).^(-b));
figure(1);
plot(flux, depth, '-');
hold on
plot(y,x,'-')
xlabel('organic carbon flux (mgC/m^2/d)');
ylabel('negative depth (m)');
title('flux of organic carbon at various depths in the ocean');

%title('iteration values for f(x) = exp(x)-x-3')