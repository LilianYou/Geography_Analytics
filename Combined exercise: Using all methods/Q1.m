%(a)
% the numerator tends to be 2.*(x.^2), the denominator tend to be 3.*(x.^2)
% so the numerator over denominator will close to 2/3

%(b)
x = [0:1:200];
f =@(x) ((x+1).*(2.*x+3))./((x+2).*(3.*x+4));
figure(1)
plot(x,f(x))
grid on
grid minor
xlabel('x')
ylabel('f(x)')
